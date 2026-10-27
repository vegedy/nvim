local function refresh_image(path)
    local ok, api = pcall(require, "image")
    if not ok then
        return
    end

    local absolutePath = vim.fn.fnamemodify(path, ":p")

    for _, image in ipairs(api.get_images()) do
        if image.original_path == absolutePath then
            image.last_modified = nil
            image:render()
        end
    end
end

local M = {}
local jobs = {}

local function notify(message, level)
    vim.notify("Org Mermaid: " .. message, level or vim.log.levels.ERROR)
end

local function render(source, output, owner)
    local running = jobs[output]

    if running then
        running.pending = source
        return
    end

    local cache = output:gsub("%.png$", ".mmd")

    if vim.fn.filereadable(output) == 1
        and vim.fn.filereadable(cache) == 1
        and table.concat(vim.fn.readfile(cache), "\n") == source then
        return
    end

    if vim.fn.executable("mmdc") ~= 1 then
        notify("mmdc wurde nicht gefunden")
        return
    end

    vim.fn.mkdir(vim.fn.fnamemodify(output, ":h"), "p")

    local temp = output .. "." .. vim.fn.getpid() .. ".tmp.png"
    vim.fn.delete(temp)

    local job = { owner = owner }
    jobs[output] = job

    local ok, err = pcall(vim.system, {
        "mmdc",
        "-i", "-",
        "-o", temp,
        "-t", "dark",
        "-b", "transparent",
        "-s", "2",
    }, {
        stdin = source .. "\n",
        text = true,
    }, function(result)
        vim.schedule(function()
            local pending = job.pending
            local current = pending == nil or pending == source

            if result.code == 0 and current then
                local renamed, renameError = vim.uv.fs_rename(temp, output)

                if renamed then
                    local written, status = pcall(
                        vim.fn.writefile,
                        vim.split(source, "\n", { plain = true }),
                        cache
                    )

                    if not written or status ~= 0 then
                        notify("Cache konnte nicht geschrieben werden: " .. cache)
                    end
                    refresh_image(output)
                else
                    notify("PNG konnte nicht ersetzt werden: " .. tostring(renameError))
                end
            elseif result.code ~= 0 and current then
                notify("Rendering fehlgeschlagen: " .. (result.stderr or ""))
            end

            vim.fn.delete(temp)
            jobs[output] = nil

            if type(pending) == "string" and pending ~= source then
                render(pending, output, owner)
            end
        end)
    end)

    if not ok then
        jobs[output] = nil
        notify(tostring(err))
    end
end

local function extract_blocks(lines)
    local blocks = {}
    local pendingName = nil
    local activeName = nil
    local inside = false
    local source = {}

    for _, line in ipairs(lines) do
        local directive = line:match("^%s*#%+([%w_]+)")
        directive = directive and directive:lower()

        if inside then
            if directive == "end_src" then
                if activeName then
                    if blocks[activeName] then
                        notify("Doppelter Blockname: " .. activeName)
                    else
                        blocks[activeName] = table.concat(source, "\n")
                    end
                end

                inside = false
                activeName = nil
                source = {}
            elseif activeName then
                source[#source + 1] = line
            end
        elseif directive == "name" then
            pendingName = line:match(
                "^%s*#%+[Nn][Aa][Mm][Ee]:%s*([%w_.-]+)%s*$"
            )
        elseif directive == "begin_src" then
            local language = line:match("^%s*#%+[%w_]+%s+([^%s]+)")

            activeName = language
                and language:lower() == "mermaid"
                and pendingName
                or nil

            pendingName = nil
            inside = true
            source = {}
        elseif not (
            line:match("^%s*$")
            or directive == "header"
            or directive == "headers"
            or directive == "caption"
            or (directive and directive:match("^attr_"))
        ) then
            pendingName = nil
        end
    end

    return blocks
end

function M.setup()
    local group = vim.api.nvim_create_augroup("OrgMermaid", {
        clear = true,
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
        group = group,
        pattern = "*.org",
        callback = function(args)
            local file = vim.api.nvim_buf_get_name(args.buf)
            local directory = vim.fs.joinpath(
                vim.fn.fnamemodify(file, ":h"),
                "attachments",
                vim.fn.fnamemodify(file, ":t:r")
            )

            local lines = vim.api.nvim_buf_get_lines(
                args.buf, 0, -1, false
            )

            local blocks = extract_blocks(lines)
            local wanted = {}

            for name, source in pairs(blocks) do
                wanted[vim.fs.joinpath(directory, name .. ".png")] = source
            end

            for output, job in pairs(jobs) do
                if job.owner == file and wanted[output] == nil then
                    job.pending = false
                end
            end

            for output, source in pairs(wanted) do
                render(source, output, file)
            end
        end,
    })
end

return M

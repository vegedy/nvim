return {
    "xheisenbugx/org.nvim",
    main = "org",
    lazy = false,
    opts = {
        org_directory = "~/Nextcloud/Dokumente/org",
        agenda_files = {
            "~/Nextcloud/Dokumente/org/**/*.org",
        },
        default_notes_file = "~/Nextcloud/Dokumente/org/inbox.org",
        archive_location = "/home/benito/Nextcloud/Dokumente/org/archive/%s_archive::",
        refile = {
            max_level = 5,
            use_outline_path = "file",
        },
        ui = {
            bullets = { "◉", "○", "✸", "✿" },
            checkboxes = { " ", "◐", "✓" },

            -- Visuelle Darstellung
            indent_mode = true,
            indent_indentation_per_level = 2,
            conceal_links = true,
            hide_emphasis_markers = true,

            -- Aufgaben
            fontify_done_headline = true,
            fontify_todo_headline = false,

            -- Codeblöcke
            src_highlight = true,
        },
    },
    init = function()
        local function applyHighlights()
            local colors = {
                "#89b4fa",
                "#cba6f7",
                "#94e2d5",
                "#f9e2af",
                "#fab387",
            }

            for level, color in ipairs(colors) do
                vim.api.nvim_set_hl(0, "OrgHeadlineLevel" .. level, {
                    fg = color,
                    bold = level <= 2,
                })
            end

            local highlights = {
                OrgTodo = { fg = "#f9e2af", bold = true },
                OrgDone = { fg = "#a6e3a1" },
                OrgHeadlineDone = { fg = "#6c7086" },
                OrgCheckboxChecked = { fg = "#a6e3a1" },
                OrgStatisticDone = { fg = "#a6e3a1" },
            }

            for group, options in pairs(highlights) do
                vim.api.nvim_set_hl(0, group, options)
            end
        end

        local group = vim.api.nvim_create_augroup("OrgCustomHighlights", {
            clear = true,
        })

        vim.api.nvim_create_autocmd("ColorScheme", {
            group = group,
            callback = applyHighlights,
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "org",
            callback = function()
                vim.opt_local.cursorline = true
                vim.opt_local.wrap = true
                vim.opt_local.linebreak = true
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
            end,
        })

        applyHighlights()
    end,
}


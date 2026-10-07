local org_dir = vim.fn.expand("~/Nextcloud/Dokumente/org")

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("OrgAppearance", { clear = true }),
    pattern = "org",
    callback = function()
        local opt = vim.opt_local

        -- Linksyntax und andere Conceal-Markierungen ausblenden
        opt.conceallevel = 2
        opt.concealcursor = "nc"

        -- Lange Zeilen nicht umbrechen
        opt.wrap = true
        opt.linebreak = true
        opt.breakindent = true
        opt.showbreak = "↳ "

        -- Weniger visuelles Rauschen
        opt.number = false
        opt.relativenumber = false
        opt.spell = false
    end,
})

return {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
        require("orgmode").setup({
	    org_agenda_files = org_dir .. "/**/*",
	    org_default_notes_file = org_dir .. "/inbox.org",

	    -- Inhalt unter Überschriften visuell einrücken
	    org_startup_indented = true,

	    -- Überschriften und Inline-Markup ruhiger darstellen
	    org_hide_leading_stars = true,
	    org_hide_emphasis_markers = true,

	    -- Zunächst Übersicht statt vollständig geöffneter Datei
	    org_startup_folded = "overview",
	    org_ellipsis = " ▸",
        })
    end,
}


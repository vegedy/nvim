local org_dir = vim.fn.expand("~/Nextcloud/Dokumente/org")

return {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
        require("orgmode").setup({
	    org_agenda_files = org_dir .. "/**/*",
	    org_default_notes_file = org_dir .. "/inbox.org",
        })
    end,
}


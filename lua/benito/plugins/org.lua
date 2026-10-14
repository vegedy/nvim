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
}


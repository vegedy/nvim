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
    },
}


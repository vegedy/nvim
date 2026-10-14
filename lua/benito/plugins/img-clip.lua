return {
    "HakonHarnes/img-clip.nvim",
    ft = { "org" },
    opts = {
        default = {
            dir_path = "attachments",
            relative_to_current_file = true,
            file_name = "%Y-%m-%d-%H-%M-%S",
            prompt_for_file_name = false,
            insert_mode_after_paste = false,
        },
        filetypes = {
            org = {
                template = "[[file:$FILE_PATH]]",
            },
        },
    },
    keys = {
        {
            "<leader>ip",
            "<cmd>PasteImage<cr>",
            ft = "org",
            desc = "Org: Bild aus Zwischenablage einfügen",
        },
    },
}

return {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    lazy = false,


    config = function()
        vim.keymap.set("n", "<leader>-", "<Cmd>Oil --float<CR>")
        require('oil').setup({
            columns = {
                "icon",
                "permissions",
                "size",
            },

            view_options = {
                show_hidden = true,
            },

            lsp_file_methods = {
                autosave_changes = true,
            },

            keymaps = {
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["<C-s>"] = { "actions.select", opts = { vertical = true } },
                ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
                ["<C-t>"] = { "actions.select", opts = { tab = true } },
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = { "actions.close", mode = "n" },
                ["<C-l>"] = "actions.refresh",
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = "actions.open_external",
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
            },
        })
    end
}

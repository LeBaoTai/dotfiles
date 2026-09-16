vim.lsp.enable({
    "gopls",
    "luals",
})

-- Apply globally first
vim.diagnostic.config({
    virtual_text = false,
    under_line = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.diagnostic.config({
            virtual_text = false,
        })
    end,
})

-- Show diagnostics only when cursor stops on a symbol
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = function()
        vim.diagnostic.open_float(nil, {
            focus = false,
            scope = "cursor",
            border = "rounded",
            source = true,
        })
    end,
})

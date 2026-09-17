local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        go = { "goimports", "gofumpt" },
    },

    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        conform.format({
            bufnr = args.buf,
            lsp_format = "fallback",
            timeout_ms = 1000,
        })
    end,
})


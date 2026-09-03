return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",

    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = { "lua", "markdown", "markdown_inline", "go", "dockerfile", "helm", "json", "gomod", "gosum", "gowork", "gotmpl" },
            sync_install = true,
            auto_install = true,
            highlight = {
                enable = true,
            }
        })
    end
}

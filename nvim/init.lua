-- Neovide setting
if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0.0
    vim.g.neovide_cursor_trail_size = 0.0
    vim.g.neovide_cursor_vfx_mode = ""
    vim.g.neovide_scroll_animation_length = 0.0

    vim.o.guifont = "Maple Mono NF CN:h12"
    vim.g.neovide_fullscreen = true
end


require('core.options')

vim.pack.add({
    -- blink cmp
    {
        src = 'https://github.com/saghen/blink.lib',
        name = 'blink.lib'
    },
    {
        src = 'https://github.com/saghen/blink.cmp',
        name = 'blink.cmp',
    },


    -- Telescope
    { src = 'https://github.com/nvim-lua/plenary.nvim',       name = 'plenary.nvim' },
    {
        src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
        name = 'telescope-fzf-native.nvim',
        build = 'make'
    },

    {
        src = 'https://github.com/nvim-telescope/telescope.nvim',
        name = 'telescope.nvim',
    },

    -- LSP
    { src = 'https://github.com/neovim/nvim-lspconfig' },

    -- formater
    { src = 'https://github.com/stevearc/conform.nvim' },

    -- mini nvim
    { src = 'https://github.com/nvim-mini/mini.nvim',         version = 'stable' },

    -- theme
    { src = 'https://github.com/folke/tokyonight.nvim', },

    -- lualine
    { src = 'https://github.com/nvim-tree/nvim-web-devicons', },
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },

    -- find and replace
    { src = 'https://github.com/MagicDuck/grug-far.nvim' },
})

require('config.telescope')
require('config.blink')
require('config.lspconfig')
require('config.conform')
require('config.mini')
require('config.theme')
require('config.lualine')
require('config.find_replace')

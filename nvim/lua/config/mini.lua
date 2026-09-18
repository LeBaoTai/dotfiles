require('mini.comment').setup()
require('mini.pairs').setup()
require('mini.ai').setup()
require('mini.icons').setup()
require('mini.cursorword').setup()
require('mini.splitjoin').setup({
    mappings = {
        toggle = 'gS',
        split = '<leader>j',
        join = 'J',
    },
})

require('mini.files').setup()
vim.keymap.set('n', '<leader>-', function() MiniFiles.open() end, { desc = 'Open MiniFiles' })
vim.keymap.set('n', '<leader>_', function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, { desc = 'Open MiniFiles' })

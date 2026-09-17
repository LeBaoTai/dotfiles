local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
    completion = {
        documentation = {
            auto_show = false
        },
    },
    keymap = {
        preset = 'none',
        ['<Tab>'] = { 'select_and_accept', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },
    },

    cmdline = {
        keymap = { preset = 'inherit' },
        completion = {
            menu = {
                auto_show = true
            }
        },
    },
})

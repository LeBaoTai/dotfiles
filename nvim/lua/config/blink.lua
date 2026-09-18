local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
        },
        menu = {
            draw = {
                columns = {
                    { "label",     "label_description", gap = 1 },
                    { "kind_icon", "kind" },
                },
            },
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

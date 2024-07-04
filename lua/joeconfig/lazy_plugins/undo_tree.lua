return {
    {
        'mbbill/undotree',
        lazy = false,
        keys = {
            {
                '<leader>1',
                function()
                    vim.cmd('UndotreeToggle')
                end,
                desc = 'Open Undo tree',
            },
        },
    },
}

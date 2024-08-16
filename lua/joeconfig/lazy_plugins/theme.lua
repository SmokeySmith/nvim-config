return {
    -- {
    --     'rose-pine/neovim',
    --     priority = 1000, -- Make sure to load this before all the other start plugins.
    --     init = function()
    --         vim.cmd.colorscheme 'rose-pine'
    --         vim.cmd.hi 'Comment gui=none'
    --     end,
    -- },

    -- {
    --     'morhetz/gruvbox',
    --     priority = 1000, -- Make sure to load this before all the other start plugins.
    --     init = function()
    --         vim.cmd.colorscheme 'gruvbox'
    --         vim.cmd.hi 'Comment gui=none'
    --     end,
    -- },

    {
        'navarasu/onedark.nvim',
        priority = 1000, -- Make sure to load this before all the other start plugins.
        init = function()
            vim.cmd.colorscheme 'onedark'
            vim.cmd.hi 'Comment gui=none'
        end,
    },

    -- {
    --     'rebelot/kanagawa.nvim',
    --     priority = 1000, -- Make sure to load this before all the other start plugins.
    --     init = function()
    --         vim.cmd.colorscheme 'kanagawa'
    --         vim.cmd.hi 'Comment gui=none'
    --     end,
    -- },
    -- {
    --     'RRethy/base16-nvim',
    --     priority = 1000, -- Make sure to load this before all the other start plugins.
    --     init = function()
    --         vim.cmd.colorscheme 'base16-rose-pine'
    --     end,
    -- }
}

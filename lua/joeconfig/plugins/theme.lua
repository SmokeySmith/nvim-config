return {
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     init = function ()
    --         vim.cmd.colorscheme("tokyonight-moon")
    --     end,
    --     opts = {},
    -- }
    {
        'rose-pine/neovim',
        priority = 1000, -- Make sure to load this before all the other start plugins.
        init = function()
            vim.cmd.colorscheme 'rose-pine'
            vim.cmd.hi 'Comment gui=none'
        end,
    },

    -- {
    --     'morhetz/gruvbox',
    --     priority = 1000, -- Make sure to load this before all the other start plugins.
    --     init = function()
    --         vim.cmd.colorscheme 'gruvbox'
    --         vim.cmd.hi 'Comment gui=none'
    --     end,
    -- },

    -- {
    --     'navarasu/onedark.nvim',
    --     priority = 1000, -- Make sure to load this before all the other start plugins.
    --     init = function()
    --         vim.cmd.colorscheme 'onedark'
    --         vim.cmd.hi 'Comment gui=none'
    --     end,
    -- },
    --
    -- {
    --     'rebelot/kanagawa.nvim',
    --     priority = 1000, -- Make sure to load this before all the other start plugins.
    --     init = function()
    --         vim.cmd.colorscheme 'kanagawa'
    --         vim.cmd.hi 'Comment gui=none'
    --     end,
    -- },

    -- {
    --     'projekt0n/github-nvim-theme',
    --     lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --     priority = 1000, -- make sure to load this before all the other start plugins
    --     config = function()
    --         require('github-theme').setup({
    --             -- ...
    --         })
    --
    --         vim.cmd('colorscheme github_dark_dimmed')
    --     end,
    -- }

    -- {
    --     "EdenEast/nightfox.nvim",
    --     lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --     priority = 1000, -- Make sure to load this before all the other start plugins.
    --     init = function()
    --         vim.cmd.colorscheme 'carbonfox'
    --     end,
    -- }
    -- {
    --     'RRethy/base16-nvim',
    --     priority = 1000, -- Make sure to load this before all the other start plugins.
    --     init = function()
    --         vim.cmd.colorscheme 'base16-rose-pine'
    --     end,
    -- }
}

return {
    -- {
    --     'rose-pine/neovim',
    --     priority = 1000, -- Make sure to load this before all the other start plugins.
    --     init = function()
    --         vim.cmd.colorscheme 'rose-pine'
    --         vim.cmd.hi 'Comment gui=none'
    --     end,
    -- },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        init = function ()
            vim.cmd.colorscheme("tokyonight-moon")
        end,
        opts = {},
    }
}

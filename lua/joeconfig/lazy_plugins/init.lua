return {
    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },

    'tpope/vim-sleuth',

    { 'numToStr/Comment.nvim', opts = {} },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = function()
            require("ibl").setup()
        end
    },
    -- enable at work
    {
        'github/copilot.vim'
    }

}

return {
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
}

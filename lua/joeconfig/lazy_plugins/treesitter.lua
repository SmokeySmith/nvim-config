return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
        ensure_installed = { "javascript", "typescript", "go", 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
            enable = true,
        },
        indent = { enable = true },
    },
    config = function(_, opts)
        -- Prefer git instead of curl in order to improve connectivity in some environments
        require('nvim-treesitter.install').prefer_git = true
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup(opts)
    end,
}

return {
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        enabled = false,
        config = function()
            local lint = require 'lint'

            lint.linters_by_ft = {
                json = { 'jsonlint' },
                -- javascript = { 'eslint'},
                -- typescript = { 'eslint'},
                -- javascriptreact = { 'eslint'},
                -- typescriptreact = { 'eslint'},
            }
            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end
            })
            vim.keymap.set("n", "<leader>ll", function()
                lint.try_lint()
            end)
        end
    }
}

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'saghen/blink.cmp',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
        -- The primary LSP setup configuration
        -- Much of the manual logic for document highlighting and method checking is removed.
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                -- Keybindings remain the same, relying on vim.lsp.buf functions
                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                map('<leader>cd', vim.diagnostic.open_float, '[D]iagnostic line')
                map('K', vim.lsp.buf.hover, 'Hover Documentation')
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                map('<leader>th', function()
                    -- New way to toggle inlay hints, cleaner than the old method check
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                end, '[T]oggle Inlay [H]ints')
            end,
        })

        -- Diagnostic Config
        vim.diagnostic.config {
            severity_sort = true,
            float = { border = 'rounded', source = 'if_many' },
            underline = { severity = vim.diagnostic.severity.ERROR },
            signs = vim.g.have_nerd_font and {
                text = {
                    [vim.diagnostic.severity.ERROR] = '󰅚 ',
                    [vim.diagnostic.severity.WARN] = '󰀪 ',
                    [vim.diagnostic.severity.INFO] = '󰋽 ',
                    [vim.diagnostic.severity.HINT] = '󰌶 ',
                },
            } or {},
            virtual_text = {
                source = 'if_many',
                spacing = 2,
                format = function(diagnostic)
                    -- This function is still valid, though you can simplify the table structure if desired
                    local diagnostic_message = {
                        [vim.diagnostic.severity.ERROR] = diagnostic.message,
                        [vim.diagnostic.severity.WARN] = diagnostic.message,
                        [vim.diagnostic.severity.INFO] = diagnostic.message,
                        [vim.diagnostic.severity.HINT] = diagnostic.message,
                    }
                    return diagnostic_message[diagnostic.severity]
                end,
            },
        }

        local capabilities = require('blink.cmp').get_lsp_capabilities()
        local data_path = vim.fn.stdpath('data')
        local vue_typescript_plugin_path = data_path ..
            '/mason/packages/vue-language-server/node_modules/@vue/language-server'

        -- Enable the following language servers
        local servers = {
            -- clangd = {},
            -- gopls = {},
            volar = {
                -- don't attach to vue files as we're using it as an extension of the ts_ls instead
                filetypes = {},
            },
            ts_ls = {
                root_dir = require("lspconfig").util.root_pattern({ "package.json", "tsconfig.json" }),
                single_file_support = false,
                settings = {},
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vue_typescript_plugin_path,
                            languages = { "vue" },
                        },
                    },
                },
            },
            denols = {
                root_dir = require("lspconfig").util.root_pattern({ "deno.json", "deno.jsonc" }),
                single_file_support = false,
                settings = {},
            },
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = 'Replace',
                        },
                    },
                },
            },
        }
        require('mason').setup()

        local ensure_installed = vim.tbl_keys(servers or {})
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {
            ensure_installed = {},
            automatic_installation = true,
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

                    -- Still need to ensure volar is skipped if using the ts_ls plugin approach
                    if server_name ~= 'volar' then
                        vim.lsp.config(server_name, server)
                        vim.lsp.enable({server_name})
                    end
                end
            },
        }
    end
}

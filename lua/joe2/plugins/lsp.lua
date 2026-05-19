return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			{
				-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
				-- used for completion, annotations and signatures of Neovim apis
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						-- Load luvit types when the `vim.uv` word is found
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
						{ path = "/usr/share/awesome/lib/", words = { "awesome" } },
					},
				},
			},
			{ "Bilal2453/luvit-meta", lazy = true },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },
			-- { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
			-- {
			-- 	"dmmulroy/tsc.nvim",
			-- 	config = function()
			-- 		require("tsc").setup({
			-- 			run_as_monorepo = true,
			-- 		})
			-- 	end,
			-- },
			--
			{
				"pmizio/typescript-tools.nvim",
				dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			},

			-- Autoformatting
			"stevearc/conform.nvim",
		},
		config = function()
			local capabilities = nil
			-- if pcall(require, "cmp_nvim_lsp") then
			-- 	capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- end

			local servers = {
				bashls = true,
				gopls = {
					manual_install = true,
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},
				lua_ls = {
					cmd = { "lua-language-server" },
				},
				rust_analyzer = true,
				pyright = true,
				-- Enabled biome formatting, turn off all the other ones generally
				ts_ls = {
					filetypes = { "javascriptreact", "typescriptreact", "javascript", "typescript" },
					-- root_dir = require("lspconfig").util.root_pattern("package.json"),
					single_file_support = false,
					settings = {},
				},
				-- denols = {
				-- 	filetypes = { "javascriptreact", "javascript", "typescriptreact", "typescript" },
				-- 	single_file_support = false,
				-- 	settings = {},
				-- },
				jsonls = {
					server_capabilities = {
						documentFormattingProvider = false,
					},
					settings = {
						json = {
							-- schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},

				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
						},
					},
				},

				clangd = {
					init_options = { clangdFileStatus = true },
					filetypes = { "c", "cpp", "h" },
				},
				omnisharp = true,
			}

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup()
			local ensure_installed = {
				"ts_ls",
				"stylua",
				"lua_ls",
				"delve",
				"omnisharp",
				-- "denols",
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- Set global capabilities for all LSP servers
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- Configure and enable each LSP server
			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end

				-- Only call vim.lsp.config if there are server-specific settings
				if next(config) ~= nil then
					-- Remove manual_install flag as it's not an LSP config field
					local lsp_config = vim.tbl_deep_extend("force", {}, config)
					lsp_config.manual_install = nil
					vim.lsp.config(name, lsp_config)
				end

				vim.lsp.enable(name)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					local settings = servers[client.name]
					if type(settings) ~= "table" then
						settings = {}
					end

					local builtin = require("telescope.builtin")

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					-- vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
					vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
					vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
					vim.keymap.set("n", "<C-k>", vim.diagnostic.open_float, { buffer = 0 })

					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
					vim.keymap.set("n", "<leader>wd", builtin.lsp_document_symbols, { buffer = 0 })
					vim.keymap.set("n", "<leader>ww", function()
						builtin.diagnostics({ root_dir = true })
					end, { buffer = 0 })

					-- Override server capabilities
					if settings.server_capabilities then
						for k, v in pairs(settings.server_capabilities) do
							if v == vim.NIL then
								---@diagnostic disable-next-line: cast-local-type
								v = nil
							end

							client.server_capabilities[k] = v
						end
					end
				end,
			})

			-- require("typescript-tools").setup({
			-- 	settings = {
			-- 		-- Performance: separate diagnostic server for large projects
			-- 		separate_diagnostic_server = true,
			-- 		-- When to publish diagnostics
			-- 		publish_diagnostic_on = "insert_leave",
			-- 		-- JSX auto-closing tags
			-- 		jsx_close_tag = {
			-- 			enable = true,
			-- 			filetypes = { "javascriptreact", "typescriptreact" },
			-- 		},
			-- 		tsserver_file_preferences = {
			-- 			includeInlayParameterNameHints = "all",
			-- 			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
			-- 			includeInlayVariableTypeHints = true,
			-- 			includeInlayVariableTypeHintsWhenTypeMatchesName = true,
			-- 			includeInlayPropertyDeclarationTypeHints = true,
			-- 			includeInlayFunctionParameterTypeHints = true,
			-- 			includeInlayEnumMemberValueHints = true,
			-- 			includeInlayFunctionLikeReturnTypeHints = true,
			-- 			-- Enable auto imports
			-- 			includeCompletionsForModuleExports = true,
			-- 			includeCompletionsForImportStatements = true,
			-- 		},
			--
			-- 		tsserver_format_options = {
			-- 			insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true,
			-- 			semicolons = "insert",
			-- 		},
			-- 		complete_function_calls = true,
			-- 		include_completions_with_insert_text = true,
			-- 		code_lens = "off",
			-- 		disable_member_code_lens = true,
			-- 		tsserver_max_memory = 12288,
			-- 	},
			-- })

			vim.lsp.config("gdscript", {
				-- cmd = { "gdscript-language-server" },
				cmd = vim.lsp.rpc.connect("0.0.0.0", 6005),
				filetypes = { "gd", "gdscript" },
				root_dir = vim.fs.root(0, { "project.godot" }),
			})

			vim.lsp.enable("gdscript")
		end,
	},
}

return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
        -- add any opts here
        -- this file can contain specific instructions for your project
        instructions_file = "Agents.md",
        -- for example
        provider = "copilot",
        -- Ensure copilot uses the custom model from vim.g.copilot_model
        behaviour = {
            auto_suggestions = false, -- Ensure this is disabled and fall back the basic copilot suggestions
        },
        providers = {
            copilot = {
                model = "claude-sonnet-4",
                timeout = 30000, -- Timeout in milliseconds
            }
        }
        --   claude = {
        --     endpoint = "https://api.anthropic.com",
        --     model = "claude-sonnet-4-20250514",
        --     timeout = 30000, -- Timeout in milliseconds
        --       extra_request_body = {
        --         temperature = 0.75,
        --         max_tokens = 20480,
        --       },
        --   },
        -- },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
        "folke/snacks.nvim",             -- for input provider snacks
        "zbirenbaum/copilot.lua",        -- for providers='copilot'
    },
}

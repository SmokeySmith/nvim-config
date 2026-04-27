return {
  {
    'github/copilot.vim',
    config = function()
      -- Set the default model for copilot.vim
      vim.g.copilot_model = 'claude-sonnet-4' -- You can change this to your preferred model
    end,
  },
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   dependencies = {
  --     { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  --   },
  --   build = "make tiktoken",                          -- Only on MacOS or Linux
  --   opts = {
  --     model = 'gpt-4.1',                              -- AI model to use
  --     temperature = 0.1,                              -- Lower = focused, higher = creative
  --     window = {
  --       layout = 'vertical',                          -- 'vertical', 'horizontal', 'float'
  --       width = 0.5,                                  -- 50% of screen width
  --     },
  --     mappings = {
  --       reset = {
  --         normal = '<C-r>',
  --         insert = '<C-r>'
  --       }
  --     },
  --     -- See Configuration section for options
  --   },
  --   keys = {
  --     {
  --       '<leader>cc',
  --       function()
  --         vim.cmd("CopilotChat")
  --       end,
  --       mode = '',
  --       desc = '[C]opilot [C]hat',
  --     },
  --   },
  --   -- See Commands section for default commands if you want to lazy load on them
  -- },
}

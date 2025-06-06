return {
    -- enable at work
  -- {
  --   'github/copilot.vim'
  -- },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      mappings = {
        reset = {
          normal = '<C-r>',
          insert = '<C-r>'
        }
      }
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}

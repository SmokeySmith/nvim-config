return {
  {
    -- i've disabled the autocompletion because i find it very annoying but i need it for chat
    'github/copilot.vim'
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      mappings = {
        reset = {
          normal = '<C-r>',
          insert = '<C-r>'
        }
      },
      -- See Configuration section for options
    },
    keys = {
        {
            '<leader>cc',
            function()
              vim.cmd("CopilotChat")
            end,
            mode = '',
            desc = '[C]opilot [C]hat',
        },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}

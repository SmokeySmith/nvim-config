return {
    'echasnovski/mini.nvim',
    config = function()
        local statusLine = require 'mini.statusline'
        statusLine.setup{ use_icons = vim.g.have_nerd_font }

        statusLine.section_location = function()
            return '%2l:%-2v'
        end
    end
}

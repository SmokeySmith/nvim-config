# basic_andy

A standard, modern Neovim config for 0.11+/0.12, managed by
[lazy.nvim](https://github.com/folke/lazy.nvim). Built alongside `joe2` — neither
touches the other.

## Enabling it

Edit `init.lua` at the repo root:

```lua
-- require("joe2")
require("basic_andy")
```

Plugin versions are pinned in `lazy-lock.basic_andy.json`, separate from `joe2`'s
`lazy-lock.json`, so the two configs can't clobber each other's pins. Both share
the plugin download directory under `stdpath("data")`, which is fine — lazy.nvim
keys installs by repo.

On first start, lazy.nvim installs plugins and Mason installs the language
servers and formatters listed in `plugins/lsp.lua`. Run `:Lazy` and
`:checkhealth` once it settles.

## Layout

```
lua/basic_andy/
  init.lua        load order
  options.lua     vim.opt, leader, diagnostics config
  keymaps.lua     global (non-plugin) keymaps
  autocmds.lua    yank highlight, cursor restore, per-filetype indent, ...
  lazy.lua        bootstrap + lazy.nvim setup
  plugins/
    colorscheme.lua  tokyonight (catppuccin/kanagawa installed but lazy)
    treesitter.lua   nvim-treesitter `main` branch + textobjects
    lsp.lua          mason + vim.lsp.config/enable, LspAttach keymaps
    completion.lua   blink.cmp
    conform.lua      formatting, format-on-save
    telescope.lua    pickers + fzf-native
    git.lua          gitsigns + fugitive
    editor.lua       mini.nvim, which-key, oil, trouble, todo-comments,
                     lualine, harpoon
```

To add a plugin, drop a new file in `plugins/` returning a spec table — the
`{ import = "basic_andy.plugins" }` in `lazy.lua` picks it up automatically.

## Keymaps

Leader is `<space>`. Press `<leader>` and pause to let which-key list things.

### Core

| Key | Action |
| --- | --- |
| `<Esc>` | clear search highlight |
| `<C-h/j/k/l>` | move between windows |
| `<C-arrows>` | resize window |
| `<S-h>` / `<S-l>` | previous / next buffer |
| `<leader>w` / `<leader>q` | write / quit |
| `<leader>bd` | delete buffer |
| `J` / `K` (visual) | move selection up/down, reindenting |
| `<leader>p` (visual) | paste over selection without yanking it |
| `<leader>d` | delete without yanking |
| `-` | open parent directory in oil |
| `<leader>l` | `:Lazy` |

### Find (telescope)

`<leader>ff` files · `<leader>fg` live grep · `<leader>fw` word under cursor ·
`<leader>fb` buffers · `<leader>fh` help · `<leader>fk` keymaps ·
`<leader>fd` diagnostics · `<leader>fo` oldfiles · `<leader>fs` document symbols ·
`<leader>fS` workspace symbols · `<leader>fr` resume · `<leader>ft` todos ·
`<leader>fn` files in this config · `<leader>/` search current buffer ·
`<leader><leader>` buffer switcher

### Code / LSP

Neovim 0.11+ ships LSP defaults already: `K` hover, `grn` rename, `gra` code
action, `grr` references, `gri` implementation, `grt` type definition,
`gO` document symbols, `<C-s>` signature help in insert mode.

Added on top: `gd` definition · `gD` declaration · `<leader>cr` rename ·
`<leader>ca` code action · `<leader>cs` signature · `<leader>ch` toggle inlay
hints · `<leader>cf` format · `<leader>cF` toggle format-on-save ·
`<leader>e` diagnostic float

Text objects from treesitter: `af`/`if` function, `ac`/`ic` class, `aa`/`ia`
parameter. Movement: `]f`/`[f`, `]F`/`[F`, `]c`/`[c`.

### Git

`<leader>gg` status (fugitive) · `<leader>gl` log · `]h`/`[h` next/prev hunk ·
`<leader>gs`/`gr` stage/reset hunk (works on a visual selection too) ·
`<leader>gS`/`gR` stage/reset buffer · `<leader>gp` preview hunk ·
`<leader>gb` blame line · `<leader>gd`/`gD` diff against index/HEAD ·
`<leader>gtb` toggle inline blame · `ih` hunk text object

### Diagnostics / quickfix

`<leader>xx` all diagnostics (trouble) · `<leader>xX` buffer only ·
`<leader>xs` symbols · `<leader>xq` quickfix · `]q`/`[q` quickfix next/prev

### Harpoon

`<leader>a` add file · `<C-e>` menu · `<leader>1`–`<leader>4` jump to file

## Notable choices

- **Diagnostics**: virtual text is off; virtual lines show on the current line
  only, so long messages don't reflow your code. Change in `options.lua`.
- **Format on save** is on, via conform, with LSP fallback. `<leader>cF`
  toggles it for the session; set `vim.b.disable_autoformat` for one buffer.
- **Indentation** defaults to 2 spaces, with 4 for Python/Rust/Scala/Java/C-family
  and real tabs for Go (`autocmds.lua`).
- **Trailing whitespace** is trimmed on save, except in markdown.
- **No Copilot / AI plugins** — `joe2` has those; add them here if you want them.
- **Treesitter** uses the `main` branch, so parsers install imperatively and
  highlighting attaches per-buffer. This is the 0.12-era API, not the old
  `configs.setup { highlight = ... }` one.

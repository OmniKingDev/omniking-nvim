# Neovim / Vim Keybind Cheat Sheet

> Personal quick-reference for Vim/Neovim editing, diagnostics, LSP, Snacks.nvim, and the custom Lua mappings we set up.

## 1. Diagnostics / Error Checking

| Key | What it does |
|---|---|
| `]d` | Jump to next diagnostic/error/warning |
| `[d` | Jump to previous diagnostic/error/warning |
| `]D` | Jump to last diagnostic in the buffer |
| `[D` | Jump to first diagnostic in the buffer |
| `<C-w>d` | Open diagnostic under cursor in a floating window |
| `<leader>d` | **Your custom mapping:** open diagnostic float |

```lua
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
```

## 2. LSP — The `gr...` Keys

| Key | Meaning | What it does |
|---|---|---|
| `K` | Hover | Show type/docs/info for symbol under cursor |
| `gra` | Action | Show code actions / quick fixes |
| `gri` | Implementation | Jump/list implementations |
| `grn` | Rename | Rename symbol through the LSP |
| `grr` | References | Find references/usages |
| `grt` | Type definition | Jump to the symbol's type definition |
| `grx` | Code lens | Run the code lens |
| `gO` | Document symbols | List symbols/functions/types in current file |
| `<C-s>` | Signature help | In Insert mode, show function signature/parameters |

```text
gra = action
gri = implementation
grn = rename
grr = references
grt = type
grx = code lens
```

## 3. Inlay Hints

This is the feature that shows labels such as:

```text
printf(format: ...)
fgets(s:, n:, stream:)
atoi(nptr:)
```

Your toggle:

```text
<leader>i
```

```lua
vim.keymap.set("n", "<leader>i", function()
    vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }),
        { bufnr = 0 }
    )
end)
```

## 4. Core Movement

| Key | Action |
|---|---|
| `h` | Left |
| `j` | Down |
| `k` | Up |
| `l` | Right |
| `w` | Next word |
| `b` | Previous word |
| `e` | End of word |
| `0` | Start of line |
| `^` | First non-whitespace character |
| `$` | End of line |
| `gg` | Top of file |
| `G` | Bottom of file |
| `{` | Previous paragraph/block |
| `}` | Next paragraph/block |
| `%` | Jump between matching brackets |

Counts work with movement:

```text
5j
3w
10G
```

## 5. Insert / Visual Modes

| Key | Action |
|---|---|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `I` | Insert at start of line |
| `A` | Insert at end of line |
| `o` | New line below |
| `O` | New line above |
| `v` | Visual character selection |
| `V` | Visual line selection |
| `<C-v>` | Visual block selection |
| `<Esc>` | Return to Normal mode |

## 6. Delete / Change / Yank / Paste

Operators:

```text
d = delete
c = change
y = yank/copy
```

Examples:

```text
dw      delete word
d$      delete to end of line
d0      delete to start of line

yw      yank word
y$      yank to end of line

cw      change word
c$      change to end of line
```

| Key | Action |
|---|---|
| `dd` | Delete current line |
| `D` | Delete cursor → end of line |
| `yy` | Yank/copy current line |
| `p` | Paste after/below |
| `P` | Paste before/above |
| `x` | Delete character |
| `u` | Undo |
| `<C-r>` | Redo |
| `.` | Repeat last change |

## 7. Text Objects

```text
iw = inner word
aw = a word

i" = inside quotes
a" = quotes + contents

i( = inside parentheses
a( = parentheses + contents

i{ = inside braces
a{ = braces + contents
```

Power combos:

```text
diw
ciw
yiw
ci"
di(
ci{
```

## 8. Search

| Key | Action |
|---|---|
| `/text` | Search forward |
| `?text` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor forward |
| `#` | Search word under cursor backward |

## 9. Jumping Around Code

| Key | Action |
|---|---|
| `%` | Matching bracket/brace/parenthesis |
| `<C-o>` | Jump backward through jump history |
| `<C-i>` | Jump forward through jump history |
| `''` | Jump back to previous position |
| `<C-]>` | Follow tag; with LSP attached Neovim can use its LSP tag function |

## 10. Windows / Splits

| Key | Action |
|---|---|
| `<C-w>h` | Window left |
| `<C-w>j` | Window down |
| `<C-w>k` | Window up |
| `<C-w>l` | Window right |
| `<C-w>w` | Cycle windows |
| `<C-w>v` | Vertical split |
| `<C-w>s` | Horizontal split |
| `<C-w>c` | Close current window |
| `<C-w>o` | Close all other windows |
| `<C-w>=` | Equalize split sizes |

## 11. Indenting

| Key | Action |
|---|---|
| `>>` | Indent line right |
| `<<` | Indent line left |
| `>` | Indent visual selection |
| `<` | Unindent visual selection |
| `=` | Auto-indent using a motion |
| `gg=G` | Re-indent whole file |

## 12. Useful Command Mode Commands

```vim
:w
:q
:wq
:q!

:e file

:bn
:bp
:bd

:LspInfo
:checkhealth vim.lsp
```

## 13. Inspect Your Actual Active Keymaps

```vim
:map
:nmap
:imap
:vmap
```

Find exactly who defined a mapping:

```vim
:verbose nmap <key>
```

Example:

```vim
:verbose nmap <leader>d
```

If Telescope is installed:

```vim
:Telescope keymaps
```

With the current Snacks.nvim setup:

```text
<leader>sk      open the Snacks keymap picker
```

## 14. Lua Keymap Syntax

```lua
vim.keymap.set("MODE", "KEY", ACTION, { desc = "Description" })
```

Example:

```lua
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
    desc = "Show diagnostic",
})
```

Modes:

```text
n = Normal
i = Insert
v = Visual
x = Visual
t = Terminal
c = Command-line
```

Multiple modes:

```lua
vim.keymap.set({ "n", "v" }, "<leader>x", some_function)
```

## 15. Snacks.nvim — Current Keybinds

These are the mappings currently added through `snacks.nvim`.

### Files / Search

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Find Git-tracked files |
| `<leader>fr` | Recent files |
| `<leader>/` | Grep project text |
| `<leader>fb` | Open buffer picker |

### Code / LSP Pickers

| Key | Action |
|---|---|
| `gd` | Find LSP definitions with Snacks picker |
| `gr` | Find LSP references with Snacks picker |

`gr` is the Snacks picker mapping. The built-in/LSP `grr` reference mapping listed earlier remains a separate key sequence unless another plugin overrides it.

### Discovery / Neovim

| Key | Action |
|---|---|
| `<leader>sk` | Search active keymaps |
| `<leader>sh` | Search help pages |
| `<leader>sC` | Search Neovim commands |
| `<leader>uC` | Browse colorschemes |

### Notifications / Utilities

| Key | Action |
|---|---|
| `<leader>n` | Open notification history |
| `<leader>bd` | Delete current buffer without disrupting the window layout |
| `<leader>gg` | Open LazyGit |

`Snacks.words` is intentionally disabled, so there are no automatic matching-word highlights or Snacks word-jump mappings in this setup.

Useful health check:

```vim
:checkhealth snacks
```

# Fast Memory Section

```text
ERRORS
]d              next diagnostic
[d              previous diagnostic
<C-w>d          explain diagnostic
<leader>d       your diagnostic popup

LSP
K               hover/docs
gra             code action
gri             implementation
grn             rename
grr             references
grt             type definition
gO              document symbols

YOUR EXTRA
<leader>i       toggle inlay hints

SNACKS
<leader>ff      find files
<leader>fg      find Git files
<leader>fr      recent files
<leader>/       grep project
<leader>fb      buffers
gd              definitions picker
gr              references picker
<leader>sk      keymaps
<leader>sh      help pages
<leader>sC      commands
<leader>uC      colorschemes
<leader>n       notification history
<leader>bd      delete buffer
<leader>gg      LazyGit

MOVEMENT
w / b           next / previous word
0 / $           line start / end
gg / G          file top / bottom
%               matching brace

EDITING
dd              delete line
yy              copy line
p               paste
u               undo
<C-r>           redo
.               repeat last change

POWER COMBOS
ciw             change word
diw             delete word
ci"             change inside quotes
ci{             change inside braces

SEARCH
/text           search
n / N           next / previous result
*               search current word

JUMPS
<C-o>           jump backward
<C-i>           jump forward
```

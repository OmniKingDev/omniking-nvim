# Personal Neovim Keybind Cheatsheet

Audited against this configuration and installed Neovim **0.12.5** on
2026-09-27. This reference includes custom mappings, enabled plugin defaults,
and useful Neovim defaults. See [Verification and caveats](#verification-and-caveats)
for what was tested.

## Reading this reference

- **Leader is Space.** `<leader>ff` means press `Space`, then `f`, then `f`.
- Keys are case-sensitive: `gO` ends with capital `O`; `uC` ends with capital `C`.
- `<C-x>` means Ctrl+x; `<S-Tab>` means Shift+Tab; `<A-x>` means Alt+x.
  `<CR>` means Enter. Sequential keys are pressed separately.
- Unless a row says otherwise, shortcuts are used in **Normal mode**.
- **Custom** means explicitly mapped in this repository, including mappings
  that call plugins. **Plugin** means an enabled plugin's own default.
  **Default** means Neovim/Vim or a bundled runtime plugin.
- Entries beginning with `:` are **commands**, not keyboard mappings. Press
  Enter to execute them. Lua API examples are also commands, not custom aliases.
- Visual means a selection made with `v`, `V`, or `<C-v>`. Operator-pending means
  waiting for a motion/text object after an operator such as `d`, `c`, or `y`.

## Fast Memory Section

```text
FILES / SEARCH (Normal)
Space ff / fg       Snacks: files / Git-tracked files
Space fr / fb       recent files / buffers
Space /             grep text in working directory
Space pv            netrw: current file's directory
Space pf / Ctrl-p   Telescope: files / Git files
Space ps            Telescope: prompt for literal grep text
Space s             prepare whole-file replacement of current word

HARPOON (Normal)
Space a             mark current file
Ctrl-e              open/close Harpoon menu
Ctrl-j / k / l / ;   marked file 1 / 2 / 3 / 4 (each with Ctrl)
:w                  save edited Harpoon list and close menu

CODE / ERRORS (Normal unless noted)
gd / gr             Snacks definitions / references
grn / gra           rename / code action
K / gO              hover / document symbols
]d / [d             next / previous diagnostic
Space ds            diagnostic popup
Space i             toggle this buffer's inlay hints
Ctrl-s              signature help (Insert/Select)
Ctrl-Space          completion menu / documentation (Insert)
Ctrl-y              accept completion (Insert)
Tab / Shift-Tab     next / previous snippet field (Insert/Select)
gcc / gc            comment line / comment selection or motion
[i / ]i             top / bottom edge of scope

GIT / UNDO / LISTS (Normal)
Space gs / gg       Fugitive status / LazyGit
Space u             undo tree
Space qk / qj       next / previous quickfix entry
Space k / j         next / previous location-list entry
Space bd            delete buffer, preserve split layout

THEMES / DISCOVERY
:Colors eve-prime   save theme and sync running Neovim instances
:Colors             print current colorscheme
Space uC            preview/select a theme for this session
Space sk / sh / sC  keymaps / help / commands
Space n             notification history
:checkhealth vim.lsp  inspect LSP setup (not :LspInfo on this version)
:lsp restart        restart current buffer's LSP clients
:SmearCursorToggle  toggle cursor animation

EDITING / MOVEMENT
w / b / e           next word / previous word / word end
0 / ^ / $           line start / first nonblank / line end
gg / G              top / bottom of file
Ctrl-d / Ctrl-u     half-page down / up, centered
Ctrl-o / Ctrl-i     older / newer jump
ciw / ci" / ci{     change word / inside quotes / inside braces
dd / yy / p         delete line / copy line / paste
u / Ctrl-r / .      undo / redo / repeat change
J / K (Visual)      move selected lines down / up
Space y{motion}     copy to system clipboard; Space yy copies a line
Space p (Visual)    replace selection while preserving paste register
Space dd{motion}    delete into black hole; Space ddd deletes a line
```

## Files, buffers, and directories

### Your file and search launchers

| Key | Source | Behavior |
|---|---|---|
| `<leader>ff` | Custom → Snacks | Find files under the current working directory |
| `<leader>fg` | Custom → Snacks | Find Git-tracked files in the repository |
| `<leader>fr` | Custom → Snacks | Pick a recently opened file |
| `<leader>fb` | Custom → Snacks | Pick an open/listed buffer |
| `<leader>/` | Custom → Snacks | Live grep under the current working directory |
| `<leader>pf` | Custom → Telescope | Find files |
| `<C-p>` | Custom → Telescope | Find Git files; Normal mode only |
| `<leader>ps` | Custom → Telescope | Ask `Grep >`, then search for that literal string using `grep_string` |
| `<leader>pv` | Custom → netrw | Run `:Ex` / `:Explore`: browse the current file's directory, or working directory for an unnamed buffer |
| `<leader>bd` | Custom → Snacks | Delete current buffer while preserving the window layout; prompts about unsaved changes |

File/grep pickers use their default filtering; hidden and ignored files are not
universally included. Snacks offers toggles below. No custom project-root or
working-directory switcher is mapped. Check `:pwd` when results come from the
wrong directory. `rg`, `fd`, Git, and `lazygit` were found in the audit environment.

### Core file and buffer commands (Default)

| Command or key | Behavior |
|---|---|
| `:w`, `:w newname` | Save; save to another filename |
| `:q`, `:wq`, `:q!` | Quit window; save and quit; quit discarding its unsaved changes if the buffer is abandoned |
| `:e file`, `:enew` | Edit a file; open an empty buffer |
| `:ls` / `:buffers` | List buffers and their numbers |
| `:b number` / `:b name` | Switch to a buffer |
| `:bn`, `:bp` or `]b`, `[b` | Next / previous buffer |
| `]B`, `[B` | Last / first buffer |
| `<C-^>` / `:b#` | Switch to alternate buffer |
| `:bd` | Delete buffer; unlike your Snacks mapping, can close its window |
| `:pwd` | Show working directory |
| `:cd path`, `:lcd path` | Change global / current-window working directory |
| `:Ex`, `:Sexplore`, `:Vexplore` | netrw directory browser in current / horizontal / vertical window |
| `gf` | Open filename under cursor |
| `gx` | Open path/URI using the system handler; also works on a Visual selection |

## Picker controls

These are **plugin defaults inside picker buffers**, not global shortcuts.

### Snacks picker

| Keys | Mode/context | Behavior |
|---|---|---|
| `<C-n>` / `<C-p>`, `<C-j>` / `<C-k>`, arrows | Input Insert/Normal | Next / previous result |
| `j` / `k`, `gg` / `G` | Normal | Move selection; first / last result |
| `<CR>` | Insert/Normal | Confirm/open selection |
| `<C-s>` / `<C-v>` / `<C-t>` | Insert/Normal | Open in horizontal split / vertical split / tab |
| `<S-CR>` | Insert/Normal | Choose a target window, then jump |
| `<Tab>` / `<S-Tab>` | Insert/Normal | Toggle selected result and move next / previous |
| `<C-a>` | Insert/Normal | Select all |
| `<C-q>` | Insert/Normal | Send selected items (or results when nothing is selected) to quickfix |
| `<C-d>` / `<C-u>` | Insert/Normal | Scroll results down / up |
| `<C-f>` / `<C-b>` | Insert/Normal | Scroll preview down / up |
| `<A-h>` / `<A-i>` | Insert/Normal | Toggle hidden / ignored files where supported |
| `<A-p>` / `<A-m>` | Insert/Normal | Toggle preview / maximize |
| `<A-r>` / `<C-g>` | Input Insert/Normal | Toggle regex / live search where supported |
| `<C-Up>` / `<C-Down>` | Input Insert/Normal | Previous / next search history |
| `<Esc>` | Insert | Return to Normal mode; press again to cancel |
| `<C-c>` | Input Insert | Cancel picker |
| `q` / `<Esc>` | Normal | Cancel picker |
| `?` | Normal | Show picker key help |
| `/` | Normal | Toggle input/list focus |
| `<C-x>` | Buffers picker input, Insert/Normal | Delete selected buffer |
| `dd` | Buffers picker list | Delete selected buffer |

### Telescope picker

| Keys | Mode/context | Behavior |
|---|---|---|
| `<C-n>` / `<C-p>`, arrows | Insert | Next / previous result |
| `j` / `k`, `gg` / `G` | Normal | Move selection; first / last result |
| `<CR>` | Insert/Normal | Open result |
| `<C-x>` / `<C-v>` / `<C-t>` | Insert/Normal | Horizontal split / vertical split / tab |
| `<Tab>` / `<S-Tab>` | Insert/Normal | Toggle result selection and move |
| `<C-u>` / `<C-d>` | Insert/Normal | Scroll preview up / down |
| `<C-q>` / `<A-q>` | Insert/Normal | Send all results / selected results to quickfix and open it |
| `<C-c>` | Insert | Close picker |
| `<Esc>` | Insert, then Normal | Leave Insert; a second Escape closes picker |
| `<C-/>` (also `<C-_>`) / `?` | Insert / Normal | Show picker key help |

In Telescope, Insert `<C-j>` is disabled and `<C-k>` scrolls the preview right;
use `<C-n>` / `<C-p>` to select results. The installed `telescope-fzf-native`
dependency is **not explicitly loaded as an extension** by this configuration.

## Harpoon: a short list of working files

All launcher mappings below are **Custom**, in Normal mode.

| Key | Behavior |
|---|---|
| `<leader>a` | Add current file to the Harpoon list |
| `<C-e>` | Toggle the quick menu |
| `<C-j>` | Select marked file 1 |
| `<C-k>` | Select marked file 2 |
| `<C-l>` | Select marked file 3 |
| `<C-;>` | Select marked file 4 |

The default list is keyed by working directory. In the menu, **plugin defaults**
provide `<CR>` to apply menu edits and select a file, and `q` / `<Esc>` to close. Edit the menu as text
to remove or reorder entries (for example, `dd`), then **`:w` to apply the list
and close**. `save_on_toggle` is false, so simply closing the menu is not a save
operation for edits. There are no configured Harpoon cycling or slots 5+ keys.

## LSP, diagnostics, and C/C++

### LSP navigation and actions

An attached server must support the requested action. The global default
`gr...` mappings exist even in buffers without an attached server.

| Key | Source / mode | Behavior |
|---|---|---|
| `gd` | Custom → Snacks, Normal | LSP definitions picker; may jump directly for a single result |
| `gr` | Custom → Snacks, Normal | LSP references picker |
| `K` | Default, buffer-local on supported LSP attachment | Hover documentation/type information |
| `gra` | Default, Normal/Visual | Code actions or quick fixes for cursor/selection |
| `gri` | Default, Normal | Implementations |
| `grn` | Default, Normal | Rename symbol through the LSP |
| `grr` | Default, Normal | References through Neovim's LSP UI |
| `grt` | Default, Normal | Type definition |
| `grx` | Default, Normal | Run an available code lens; requires server-provided lenses |
| `gO` | Default, Normal | Document symbols |
| `<C-s>` | Default, Insert/Select | Signature/parameter help |
| `<C-]>` | Default, Normal | Follow tag; LSP sets `tagfunc` when supported |
| `<C-t>` | Default, Normal | Return through tag stack |
| `<leader>i` | Custom, Normal | Toggle native inlay hints for this buffer |

Inlay hints are labels such as `printf(format: ...)` or `atoi(nptr: ...)`.
Your `LspAttach` autocmd enables them when the attaching client supports them.
The toggle is buffer-local in effect, and a later supporting attachment can
turn hints on again.

### Diagnostics

| Key | Source | Behavior |
|---|---|---|
| `<leader>ds` | Custom | Diagnostic floating window for current line (default `open_float()` scope) |
| `<C-w>d`, `<C-w><C-d>` | Default | Same diagnostic float |
| `]d` / `[d` | Default | Next / previous diagnostic; counts work, e.g. `3]d` |
| `]D` / `[D` | Default | Last / first diagnostic in buffer |

Diagnostics include warnings, information, and hints as well as errors.
`<leader>d` alone is **not** a diagnostic mapping.

Useful commands (Default APIs; no custom aliases):

```vim
:lua vim.diagnostic.setqflist()
:lua vim.diagnostic.setloclist()
:lua vim.lsp.buf.format({ async = true })
:checkhealth vim.lsp
:lsp restart
:lsp stop
:lsp enable clangd
:lsp disable clangd
```

`setqflist()` collects workspace diagnostics; `setloclist()` uses the current
buffer by default. Lists are separate from diagnostic jump navigation.
Formatting is server-dependent; there is no custom format shortcut or
format-on-save autocmd. `gq{motion}` can use LSP range formatting when the server
sets `formatexpr`; `=` remains indentation, not an LSP formatting shortcut.

**Version correction:** `:LspInfo`, `:LspStart`, and `:LspStop` are not registered
in this installed setup. nvim-lspconfig skips its old commands because Neovim
provides `:lsp`. Use `:checkhealth vim.lsp` and lowercase `:lsp` commands above.

### Which servers run?

`lspconfig.lua` scans runtime `lsp/*.lua` definitions, excludes `gitlab_duo`, and
enables each configuration whose table-valued `cmd[1]` is executable. Filetype,
root detection, and server-specific requirements then control actual attachment.
Mason exposes installed tools, but there is no fixed Mason `ensure_installed`
server list or mason-lspconfig bridge.

The audit discovered enabled configurations for `clangd`, `lua_ls`, `gopls`,
`pyright`, `rust_analyzer`, `denols`, `stylua`, `fsharp_language_server`,
`msbuild_project_tools_server`, `perlls`, `turtle_ls`, `unison`, `vespa_ls`, and
`tvm_ffi_navigator`. **This is an executable-discovery snapshot, not proof that
all these servers work.** Only clangd attachment was exercised. Generic commands
such as an interpreter can pass the check even when a particular server cannot
start. Use LSP health in the actual project to see what attached.

clangd is configured with background indexing, clang-tidy, IWYU header insertion,
detailed completion, argument placeholders, UTF-16 offsets, and LLVM fallback
formatting. Root markers include compilation databases/flags, Makefiles,
Autotools, Meson, Ninja, and `.git`. Project compile settings still determine
accurate include paths and diagnostics. A separate `lua_ls` settings override
exists; it does not establish that all Lua diagnostics are suppressed correctly.

### C/C++ commands and automatic behavior

`clangd_extensions.nvim` loads for `c`, `cpp`, `objc`, and `objcpp` filetypes.
These are **plugin commands**, with **no custom keyboard bindings**:

| Command | Behavior / context |
|---|---|
| `:ClangdSwitchSourceHeader` | Switch between source and header |
| `:ClangdAST` | Show clangd AST; accepts a range such as `:'<,'>ClangdAST` |
| `:ClangdTypeHierarchy` | Show type hierarchy for symbol |
| `:ClangdSymbolInfo` | Show clangd symbol information |
| `:ClangdMemoryUsage` | Show clangd memory usage |
| `:ClangdMemoryUsage expand_preamble` | Include expanded preamble details |

These require clangd and its corresponding extension requests. Command
registration was verified; every server request was not exercised.

For **C and C++ only**, `after/ftplugin/c.lua` and `cpp.lua` load the shared
control-flow behavior: `exit` and `_exit` followed by optional whitespace and
`(` receive a window-local `OmniControlFlow` match linked to `@keyword.return`.
It reapplies on buffer/window entry and colorscheme changes. This is a text
pattern, not an AST check, so matching text in comments/strings can also receive
the highlight. Cleanup runs only in C/C++ buffers; switching the same window to
another filetype can leave that window-local match active. The extensions option
`inlay_hints.inline = false` is not used
by the installed extension code; displayed hints come from native Neovim LSP.

## Completion, snippets, and automatic pairs

Blink uses its **default preset**, with LSP, path, snippets, and buffer sources.
`friendly-snippets` supplies snippets through Neovim's native snippet support.
Documentation is not shown automatically.

| Key | Source / mode | Behavior |
|---|---|---|
| `<C-Space>` | Blink, Insert | Show menu; with menu open, show/hide completion documentation |
| `<C-n>` / `<C-p>`, arrows | Blink, Insert | Next / previous item when completion is active |
| `<C-y>` | Blink, Insert | Accept selected item, or select/accept the first item |
| `<C-e>` | Blink, Insert | Cancel completion and undo its previewed insertion |
| `<C-b>` / `<C-f>` | Blink, Insert | Scroll completion documentation up / down |
| `<Tab>` / `<S-Tab>` | Blink, Insert/Select | Next / previous snippet placeholder; otherwise fall back |
| `<C-s>` | Neovim default, Insert/Select | LSP signature help |
| `<C-c>` | Custom, Insert | Escape to Normal mode |

**Enter is not Blink's accept key, and Tab is not a general completion-accept
key in Insert mode.** Blink installs a `<C-k>` signature mapping, but its
`signature.enabled` default is false here, so that action falls back rather
than showing signatures. Use `<C-s>`.

Blink also enables **command-line completion** for `:` and searches: `<Tab>`
shows/inserts a candidate or accepts a single result, then cycles; `<S-Tab>`
cycles backward. `<C-n>` / `<C-p>` and Left/Right select candidates when active;
`<C-y>` accepts, `<C-e>` cancels, and `<End>` hides completion. These are separate
from Insert-mode snippet behavior. `:BlinkCmp status` opens its health report.

`nvim-autopairs` loads on the first `InsertEnter`. It inserts matching quotes and
brackets, skips an existing closer where its rules allow, handles paired
Backspace, and maps Enter to pair-aware line breaks. It is disabled in
`TelescopePrompt`, `spectre_panel`, and `snacks_picker_input`, while
recording/executing macros, and in Replace mode. There is no configured fast-wrap
mapping. Plugin functions are available as commands if needed:

```vim
:lua require('nvim-autopairs').disable()
:lua require('nvim-autopairs').enable()
```

## Git

| Key | Source | Behavior |
|---|---|---|
| `<leader>gs` | Custom → Fugitive | Open `:Git` status |
| `<leader>gg` | Custom → Snacks | Open external LazyGit in a terminal window |

Fugitive status has **buffer-local plugin mappings**:

| Key | Behavior in Fugitive status |
|---|---|
| `s` / `u` / `-` | Stage / unstage / toggle staging for file or hunk |
| `=` | Toggle inline diff |
| `<CR>` | Open item under cursor |
| `dd` / `dv` | Open diff / vertical diff for file |
| `cc` | Prepare a commit |
| `g?` | Show context-sensitive Fugitive mapping help |

Useful **Fugitive commands**:

| Command | Behavior |
|---|---|
| `:Git` | Repository status |
| `:Git diff`, `:Git log`, `:Git blame` | Git diff, history, or blame view |
| `:Git commit` | Commit staged changes through Fugitive's commit workflow |
| `:Gdiffsplit`, `:Gvdiffsplit` | Diff current file against index, optionally specify another object |
| `:Gclog` | Load current file's commit history into quickfix |
| `:Gwrite` | Write current file **and stage it** |

There is no configured Gitsigns plugin or custom hunk-navigation/staging mapping.
LazyGit keys belong to the external application, not these Neovim mappings.

## Undo history, quickfix, and location lists

### Undo

| Key or command | Source | Behavior |
|---|---|---|
| `u` / `<C-r>` | Default | Undo / redo |
| `g-` / `g+` | Default | Older / newer text state across undo branches |
| `<leader>u` | Custom | Toggle Undotree panel |
| `:UndotreeToggle`, `:UndotreeShow`, `:UndotreeHide` | Plugin | Toggle / show / hide panel |
| `:UndotreeFocus` | Plugin | Focus the tree |
| `:earlier 5m`, `:later 5m` | Default | Move through undo history by time |

Inside Undotree (**plugin defaults**): `J` / `K` move to previous / next undo
state, `<CR>` selects the state under cursor, `u` / `<C-r>` undo/redo, `D` toggles
the diff panel, `?` toggles help, `<Tab>` returns to the editor, and `q` closes.

Persistent undo is configured in `~/.vim/undodir`. Swap and backup files are
disabled. Saved undo history can survive restarting Neovim when the undo
directory is usable.

### Quickfix versus location list

Quickfix is shared; each window has its own location list. Grep, diagnostics,
and LSP results can populate these lists. They are not automatic lists of fixes.

| Key | Source | Behavior |
|---|---|---|
| `<leader>qk` / `<leader>qj` | Custom | **Next / previous quickfix** entry, then center |
| `<leader>k` / `<leader>j` | Custom | **Next / previous location-list** entry, then center |
| `]q` / `[q` | Default | Next / previous quickfix entry |
| `]Q` / `[Q` | Default | Last / first quickfix entry |
| `]l` / `[l` | Default | Next / previous location-list entry |
| `]L` / `[L` | Default | Last / first location-list entry |

Commands: `:copen`, `:cclose`, `:cnext`, `:cprev` for quickfix;
`:lopen`, `:lclose`, `:lnext`, `:lprev` for the location list.
The custom directions really are **k = next, j = previous**.

## Themes and visual utilities

### Persistent theme switching

| Command or key | Source | Behavior |
|---|---|---|
| `:Colors` | Custom command | Print currently active colorscheme |
| `:Colors name` | Custom command | Validate available name, save it, and apply immediately |
| `:Colors eve` | Custom command | Select canonical EVE persistently |
| `:Colors eve-prime` | Custom command | Select EVE-PRIME persistently |
| `:Colors eve-darkmatrix` | Custom command | Select EVE-DARKMATRIX persistently |
| `:Colors eve-matrix` | Custom command | Select EVE-MATRIX persistently |
| `<leader>uC` | Custom → Snacks | Browse colorschemes with live preview; confirm for this session |
| `:colorscheme name` | Default command | Change current session's colorscheme |
| `:SmearCursorToggle` | Plugin command | Toggle smear-cursor animation |

`:Colors` supports colorscheme completion. The saved name lives in
`stdpath('state')/global_theme.txt` (normally
`~/.local/state/nvim/global_theme.txt`). Each instance applies the saved theme
on startup and polls that file every **500 ms**, applying changes from other
instances. Missing/empty state falls back to `rose-pine-moon`; the saved name at
audit time was `eve-prime`.

The picker uses `:colorscheme`, **not `:Colors`**, so it does not save or broadcast
your choice. A session-only choice remains until another disk-theme change or
restart. Several theme plugins apply schemes during startup; the saved-theme
loader in `after/plugin/colors.lua` then applies the saved choice. A failed
startup/poll application is swallowed by `pcall`, rather than falling back to
another valid theme. A failed state-file write is also silent, so persistence
requires a writable state directory.

Configured theme plugins supply Rose Pine (`rose-pine`, `rose-pine-main`,
`rose-pine-moon`, `rose-pine-dawn`), Tokyo Night (`tokyonight` and its day/moon/night/
storm variants), `miasma`, and `vantablack`, alongside bundled Neovim schemes.
Use `:Colors <Tab>` to discover the actual available names.

The four local EVE schemes read their corresponding files in `themes/ghostty/`,
then apply semantic highlights and shared surface settings. With
`use_terminal_background = true`, editor and listed UI surfaces use `bg=NONE`,
letting the terminal background show through. This does not switch the terminal's
own theme. Smear-cursor animates movement, window/buffer changes, scrolling, and
Insert-mode movement; it has no custom shortcut.

OmniVeil is your unfinished local project. `:OmniVeilInfo`, `:OmniVeilStart`, and
`:OmniVeilStop` exist, but outline/background effects are disabled and the current
implementation reports no host effect adapter. No effect-toggle key is mapped.

## Editing: modes, operators, clipboard, and text objects

### Entering modes (Default unless marked)

| Key | Behavior |
|---|---|
| `i` / `a` | Insert before / after cursor |
| `I` / `A` | Insert at first nonblank / end of line |
| `o` / `O` | Open a new line below / above and enter Insert |
| `v` / `V` / `<C-v>` | Character / line / block Visual selection |
| `<Esc>` | Return to Normal mode |
| `<C-c>` in Insert | **Custom:** act as Escape |

### Operators and ordinary editing

`d` deletes, `c` changes (deletes and enters Insert), and `y` yanks/copies.
Combine an operator with a motion or text object. A count repeats the operation.

```text
dw / d$ / d0      delete word / to line end / to line start
yw / y$           copy word / to line end
cw / c$           change word / to line end
3dd               delete three lines
```

| Key | Source / mode | Behavior |
|---|---|---|
| `dd` / `D` | Default, Normal | Delete line / to end of line |
| `yy` / `Y` | Default, Normal | Copy line / to end of line (`Y` is `y$` in Neovim) |
| `p` / `P` | Default, Normal | Paste after/below / before/above |
| `x` | Default, Normal | Delete character |
| `.` | Default, Normal | Repeat last change |
| `J` | Custom, Normal | Join next line while restoring cursor position; uses mark `z` |
| `J` / `K` | Custom, Visual | Move selected lines down / up, reindent and reselect |
| `gcc` | Default, Normal | Toggle current line comment |
| `gc{motion}` / `gc` on selection | Default, Normal / Visual | Toggle comments over motion / selection |
| `>>` / `<<` | Default, Normal | Indent / unindent line |
| `>` / `<` | Default, Visual | Indent / unindent selection |
| `={motion}`, `gg=G` | Default, Normal | Reindent motion / whole file |
| `[<Space>` / `]<Space>` | Default, Normal | Add blank line above / below without entering Insert |

Indent settings are four spaces: `tabstop=4`, `softtabstop=4`, `shiftwidth=4`,
`expandtab`, and `smartindent`. Filetype runtime plugins may adjust local options.

### Custom clipboard and safe-paste mappings

| Key | Mode | Behavior |
|---|---|---|
| `<leader>y{motion}` | Normal | Yank to system clipboard register `+`; `<leader>yy` copies a line |
| `<leader>y` | Visual | Copy selection to system clipboard |
| `<leader>Y` | Normal | Copy whole line to `+`; nonrecursive RHS uses native `Y`, bypassing Neovim's `Y → y$` mapping |
| `<leader>p` | Visual | Replace selection through black-hole delete, preserving the register being pasted |
| `<leader>dd{motion}` | Normal | Begin black-hole deletion; **still needs a motion** |
| `<leader>dd` | Visual | Delete selection into black-hole register |

For a whole line without replacing copied text, type **`<leader>ddd`**; for a
word, `<leader>ddw`. The source comment saying deleted lines go to the clipboard
is incorrect: the mapping uses register `_`, which discards text.

Plain `y`, `d`, and `p` use normal Vim registers; the config does not set an
unnamed system clipboard. Use `"+p` to paste from the system clipboard.
Clipboard helpers were present; actual terminal/clipboard round trips were not
tested. Mappings created with mode `v` also apply to Select mode, including
`J`, `K`, `<leader>y`, and `<leader>dd`; `<leader>p` uses `x` (Visual only).

### Text objects

Use these after `d`, `c`, `y`, or while selecting. **Default** unless marked.

| Object | Meaning | Examples |
|---|---|---|
| `iw` / `aw` | Inner word / word including adjacent whitespace | `ciw`, `diw`, `yiw`, `daw` |
| `i"` / `a"` | Inside double quotes / including quotes | `ci"` |
| `i(` / `a(` | Inside parentheses / including parentheses | `di(` |
| `i{` / `a{` | Inside braces / including braces | `ci{` |
| `ii` / `ai` | **Snacks scope:** inner / full scope including edges | `vii`, `dai` |
| `in` / `an` | Neovim syntax-node inner / outer selection | Visual shrink/grow or operator text objects |

Snacks scope uses Tree-sitter with indentation fallback. Its `ii`/`ai` text
objects and `[i`/`]i` jumps are enabled automatically by `scope.enabled=true`.
Neovim's `in`/`an` use Tree-sitter when available, with LSP selection-range
fallback. Visual `[n` / `]n` select previous / next syntax nodes; `[N` / `]N`
extend to the previous / next sibling. These node selections need syntax support.

## Movement, searches, and jump history

### Core movement

| Key | Source | Behavior |
|---|---|---|
| `h` / `j` / `k` / `l` | Default | Left / down / up / right |
| `w` / `b` / `e` | Default | Next word / previous word / end of word |
| `0` / `^` / `$` | Default | Line start / first nonblank / line end |
| `gg` / `G` / `10G` | Default | First line / last line / line 10 |
| `{` / `}` | Default | Previous / next paragraph; not a syntax-aware code-block jump |
| `%` | Bundled matchit/default | Matching brackets and filetype-defined pairs |
| `[i` / `]i` | Snacks plugin, Normal/Visual/operator-pending | Top / bottom edge of scope |
| `<C-d>` / `<C-u>` | Custom | Half-page down / up, then center cursor line |
| `<C-f>` / `<C-b>` | Default | Full page forward / backward |
| `zz` | Default | Center current line |
| `<C-o>` / `<C-i>` | Default | Older / newer entry in jump history |
| `''` | Default | Previous jump mark's line, at first nonblank |
| Two backticks: <code>``</code> | Default | Previous jump mark's exact line and column |

Counts combine with movement: `5j`, `3w`, `10G`. Absolute and relative line
numbers are enabled, wrapping is off, and `scrolloff=8` keeps context near the
cursor where possible.

### Search and replace

| Key or command | Source | Behavior |
|---|---|---|
| `/text<CR>` / `?text<CR>` | Default | Search forward / backward |
| `n` / `N` | Custom, Normal | Next / previous match relative to search direction; center and open folds |
| `*` / `#` | Default | Search current word forward / backward; Visual uses selected text |
| `<leader>s` | Custom, Normal | Prepare whole-file whole-word substitution of word under cursor |
| `:%s/old/new/gc` | Default command | Replace matches throughout file with confirmation |
| `:nohlsearch` | Default command | Clear current search highlighting |

`<leader>s` inserts `:%s/\<word\>/word/gI` and positions the command-line cursor
in the replacement. Edit it and press Enter. `g` replaces every match on each
line; `I` forces case-sensitive matching. There is **no confirmation flag** in
this mapping. Incremental search is enabled; persistent `hlsearch` is disabled.

## Windows, tabs, and terminal

### Splits (Default unless marked)

| Key | Behavior |
|---|---|
| `<C-w>h` / `j` / `k` / `l` | Move to left / lower / upper / right window |
| `<C-w>w` | Cycle windows |
| `<C-w>v` / `<C-w>s` | Vertical / horizontal split |
| `<C-w>c` / `<C-w>o` | Close current / all other windows |
| `<C-w>=` | Equalize sizes |
| `<C-w>+` / `<C-w>-` | Increase / decrease height |
| `<C-w>>` / `<C-w><` | Increase / decrease width |
| `<C-S-,>` | **Custom:** decrease width by one column (`:vertical resize -1`) |
| `<C-S-.>` | **Custom:** increase width by one column (`:vertical resize +1`) |
| `<C-+>` / `<C-_>` | **Custom:** increase / decrease height by one line |

The custom resize keys change the current **window**, not the buffer. Their
terminal encoding depends on the terminal/key protocol; the actual terminal
keystrokes were not tested. Use the standard `<C-w>` alternatives or the exact
`:resize` commands if these chords do not arrive correctly.

Commands: `:split file`, `:vsplit file`, `:tabnew`, `:tabclose`.
`gt` / `gT` go to next / previous tab (Default).

`:terminal` opens a terminal buffer (Default). In Terminal mode, press
`<C-\><C-n>` to enter Terminal-Normal mode; `i` returns to terminal input.
There is no custom general terminal toggle mapping.

## Custom execution, discovery, and plugin utilities

| Key or command | Source | Behavior |
|---|---|---|
| `<leader><leader>x` | Custom, Normal | `:source %`: execute current file from disk as Vimscript/Lua as appropriate; does not save first |
| `<leader>x` | Custom, Normal | Run `:!chmod +x %` on current file; does not run the program |
| `<leader>sk` | Custom → Snacks | Search keymaps |
| `<leader>sh` | Custom → Snacks | Search help pages |
| `<leader>sC` | Custom → Snacks | Search Neovim commands |
| `<leader>n` | Custom → Snacks | Notification history |
| `:Telescope keymaps` | Plugin command | Telescope keymap picker |
| `:Lazy` | Plugin command | Plugin manager UI/status |
| `:Mason`, `:MasonLog` | Plugin commands | External-tool manager / log |
| `:Neoconf` | Plugin command | Choose local/global settings file to edit |
| `:Neoconf local`, `:Neoconf global` | Plugin commands | Edit project / global settings |
| `:Neoconf show`, `:Neoconf lsp` | Plugin commands | Inspect merged settings / LSP settings |
| `:Inspect`, `:InspectTree` | Default commands | Inspect highlights at cursor / syntax tree |
| `:TSLog` | Plugin command | Open Tree-sitter installation log |
| `:messages` | Default command | Review Neovim messages/errors |
| `:checkhealth snacks`, `:checkhealth blink.cmp` | Default commands | Plugin health checks |

The chmod mapping uses an unquoted `%` in a shell command; unusual filenames
such as paths with spaces can fail. No build, run, test, breakpoint, stepping,
or debugger/DAP mapping is configured. clangd analysis and diagnostics are not
a debugger.

Tree-sitter starts on every FileType event through `pcall(vim.treesitter.start)`;
unavailable parsers fail quietly. The startup configuration also requests all
`stable`, `unstable`, and `unmaintained` parser tiers. `:TSInstall`, `:TSUpdate`,
and `:TSUninstall` are available plugin maintenance commands, but are not normal
editing shortcuts. No parser installation/update was run for this audit.

Snacks also enables input prompts, notifications (3-second timeout), quickfile,
and bigfile handling. Large/minified files can be assigned filetype `bigfile`
and have features reduced (default thresholds: over 1.5 MiB or average line
length over 1000 bytes). Matching-word highlighting/jumps via `Snacks.words`
are disabled. No Snacks explorer/dashboard/zen mappings are configured.

## Mapping overlaps and changed behavior

| Keys/context | Effective behavior or caveat |
|---|---|
| `<leader>d` | No standalone mapping. Diagnostic float is `<leader>ds`; `<leader>dd` begins black-hole deletion |
| `<leader>s` with `sk`, `sh`, `sC` | Shorter substitution mapping shares a prefix with discovery mappings; may wait for `timeoutlen` |
| `<leader>u` with `uC` | Undo-tree toggle shares a prefix with theme picker; may wait for `timeoutlen` |
| `gr` with `gra/gri/grn/grr/grt/grx` | Snacks references shares a prefix with Neovim LSP keys; longer keys remain mapped, but `gr` can wait |
| `<C-j>`, `<C-k>`, `<C-l>`, `<C-e>` in Normal | Harpoon overrides their normal line/scroll/redraw behavior; `<C-l>` no longer runs Neovim's redraw/search-clear mapping |
| `gd` / `gr` in Normal | Replaced by LSP pickers; no longer ordinary Vim local-declaration / virtual-replace operations |
| `[i` / `]i` | Snacks scope jumps override Vim's identifier-search commands |
| `J` / `K` in Visual | Move lines; `J` no longer joins the selection |
| `Q` in Normal | Explicitly disabled with `<nop>`; does not replay last macro. `@q` / `@@` remain standard macro replay commands |
| Picker, Fugitive, Undotree, Harpoon buffers | Buffer-local mappings take precedence over global editing mappings |
| `<C-e>`, `<C-p>`, `<C-k>` in Insert | Completion/fallback behavior, not Harpoon/Telescope navigation |
| `<C-s>` in picker input | Picker split action, not LSP signature help |
| `<C-k>` in Blink | Signature action is installed but disabled; use Neovim `<C-s>` |
| `<leader>Y` versus `Y` | Custom clipboard mapping copies a line; ordinary Neovim `Y` copies to end of line |

The tmux-sessionizer `<C-f>` line is commented out and inactive. There is no
separate exact-key collision between the configured global custom mappings;
the main issues are shared prefixes, overrides of defaults, and buffer/mode
context. Use `:set timeout? timeoutlen?` to inspect mapping wait behavior.

## Inspect the active setup yourself

```vim
:map
:nmap
:imap
:vmap
:xmap
:omap
:cmap
:verbose nmap <leader>ds
:verbose nmap gr
:verbose imap <C-y>
:verbose nmap <buffer>
:command Colors
:command ClangdAST
:autocmd LspAttach
:autocmd OmniControlFlowBehavior
:set filetype?
:checkhealth vim.lsp
```

Inspect filetype-local maps **in the relevant buffer**. For completion, enter
Insert at least once; for clangd extension commands, open a C/C++/Objective-C
buffer. To check server attachment directly:

```vim
:lua vim.print(vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({ bufnr = 0 })))
```

Lua keymap syntax reminder (not an extra configured shortcut):

```lua
vim.keymap.set('n', '<leader>ds', vim.diagnostic.open_float)
```

Modes: `n` Normal, `i` Insert, `v` Visual **and Select**, `x` Visual only,
`s` Select, `o` operator-pending, `t` Terminal, `c` command-line.
Multiple modes use a table such as `{ 'n', 'x' }`.

## Verification and caveats

The loading chain is `init.lua` → `lua/omniking_lua/init.lua` → `remap`, `set`,
and `config.lazy` → imported `plugins/*.lua` specs. Lazy loads most plugins at
startup; autopairs waits for InsertEnter and clangd extensions for their listed
filetypes. `after/plugin/*.lua` configures the secondary mappings, themes,
Tree-sitter, and LSP hook. The C/C++ ftplugins import `lang/control_flow.lua`.
Theme entrypoints import palettes, highlights, and shared surface configuration.

This audit read those sources, the previous cheatsheet, the lockfile, and
relevant installed plugin/Neovim implementations. Headless checks inspected
actual global/buffer mappings and commands, triggered filetype and InsertEnter
loading, simulated UIEnter for Snacks scope/picker setup, opened a Snacks file
picker and Harpoon/Undotree panels, attached clangd, checked automatic hints,
and loaded all four EVE colorschemes successfully.

The check used temporary state/cache/data locations, existing installed plugins,
and suppressed automatic plugin/parser installation. It did not exercise every
language server, external LazyGit UI, terminal key encoding, clipboard exchange,
or live synchronization between real user sessions. Plugin controls not
explicitly exercised above were checked against installed source. No Neovim
configuration, plugin version, or user theme-state file was changed.

let mapleader=" "
set tabstop=4
set shiftwidth=3
set expandtab
set hidden
set scrolloff=10
set ai
set si
set clipboard=unnamedplus
set cursorline
set termguicolors
set mouse=a
set number
set signcolumn=number
set noshowmode
set wrap
set linebreak
set guifont=meslolgs\ nf:h10.5
set completeopt=longest,menuone
set t_Co=256
set textwidth=79
let g:nvim_tree_auto_close = 1

call plug#begin('~/.local/share/nvim/plugged')
Plug 'projekt0n/github-nvim-theme'
Plug 'jiangmiao/auto-pairs'
Plug 'windwp/windline.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'phaazon/hop.nvim'
Plug 'p00f/nvim-ts-rainbow'
" Plug 'olimorris/onedarkpro.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'dominikduda/vim_current_word'
Plug 'mlaursen/vim-react-snippets'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nestorsalceda/vim-strip-trailing-whitespaces'
Plug 'dracula/vim', { 'as': 'dracula' } " theme
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
" Plug 'vim-airline/vim-airline' " the statusbar
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'steelsojka/pears.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
Plug 'tpope/vim-commentary'
Plug 'folke/twilight.nvim'
Plug 'folke/zen-mode.nvim'
call plug#end()

" autocmd FileType vim :Gitsign toggle_deleted

lua << EOF
  local windline = require('windline')
  local helper = require('windline.helpers')
  local b_components = require('windline.components.basic')
  local state = _G.WindLine.state

  local lsp_comps = require('windline.components.lsp')
  local git_comps = require('windline.components.git')

  local hl_list = {
      Black = { 'white', 'black' },
      White = { 'black', 'white' },
      Inactive = { 'InactiveFg', 'InactiveBg' },
      Active = { 'ActiveFg', 'ActiveBg' },
  }
  local basic = {}

  local breakpoint_width = 90
  basic.divider = { b_components.divider, '' }
  basic.bg = { ' ', 'StatusLine' }

  local colors_mode = {
      Normal = { 'red', 'black' },
      Insert = { 'green', 'black' },
      Visual = { 'yellow', 'black' },
      Replace = { 'blue_light', 'black' },
      Command = { 'magenta', 'black' },
  }

  basic.vi_mode = {
      name = 'vi_mode',
      hl_colors = colors_mode,
      text = function()
          return { { '  ', state.mode[2] } }
      end,
  }
  basic.square_mode = {
      hl_colors = colors_mode,
      text = function()
          return { { '▊', state.mode[2] } }
      end,
  }

  basic.lsp_diagnos = {
      name = 'diagnostic',
      hl_colors = {
          red = { 'red', 'black' },
          yellow = { 'yellow', 'black' },
          blue = { 'blue', 'black' },
      },
      width = breakpoint_width,
      text = function(bufnr)
          if lsp_comps.check_lsp(bufnr) then
              return {
                  { lsp_comps.lsp_error({ format = '  %s', show_zero = true }), 'red' },
                  { lsp_comps.lsp_warning({ format = '  %s', show_zero = true }), 'yellow' },
                  { lsp_comps.lsp_hint({ format = '  %s', show_zero = true }), 'blue' },
              }
          end
          return ''
      end,
  }
  basic.file = {
      name = 'file',
      hl_colors = {
          default = hl_list.Black,
          white = { 'white', 'black' },
          magenta = { 'magenta', 'black' },
      },
      text = function(_, _, width)
          if width > breakpoint_width then
              return {
                  { b_components.cache_file_size(), 'default' },
                  { ' ', '' },
                  { b_components.cache_file_name('[No Name]', 'unique'), 'magenta' },
                  { b_components.line_col_lua, 'white' },
                  { b_components.progress_lua, '' },
                  { ' ', '' },
                  { b_components.file_modified(' '), 'magenta' },
              }
          else
              return {
                  { b_components.cache_file_size(), 'default' },
                  { ' ', '' },
                  { b_components.cache_file_name('[No Name]', 'unique'), 'magenta' },
                  { ' ', '' },
                  { b_components.file_modified(' '), 'magenta' },
              }
          end
      end,
  }
  basic.file_right = {
      hl_colors = {
          default = hl_list.Black,
          white = { 'white', 'black' },
          magenta = { 'magenta', 'black' },
      },
      text = function(_, _, width)
          if width < breakpoint_width then
              return {
                  { b_components.line_col_lua, 'white' },
                  { b_components.progress_lua, '' },
              }
          end
      end,
  }
  basic.git = {
      name = 'git',
      hl_colors = {
          green = { 'green', 'black' },
          red = { 'red', 'black' },
          blue = { 'blue', 'black' },
      },
      width = breakpoint_width,
      text = function(bufnr)
          if git_comps.is_git(bufnr) then
              return {
                  { git_comps.diff_added({ format = '  %s', show_zero = true }), 'green' },
                  { git_comps.diff_removed({ format = '  %s', show_zero = true }), 'red' },
                  { git_comps.diff_changed({ format = ' 柳%s', show_zero = true }), 'blue' },
              }
          end
          return ''
      end,
  }

  local quickfix = {
      filetypes = { 'qf', 'Trouble' },
      active = {
          { '🚦 Quickfix ', { 'white', 'black' } },
          { helper.separators.slant_right, { 'black', 'black_light' } },
          {
              function()
                  return vim.fn.getqflist({ title = 0 }).title
              end,
              { 'cyan', 'black_light' },
          },
          { ' Total : %L ', { 'cyan', 'black_light' } },
          { helper.separators.slant_right, { 'black_light', 'InactiveBg' } },
          { ' ', { 'InactiveFg', 'InactiveBg' } },
          basic.divider,
          { helper.separators.slant_right, { 'InactiveBg', 'black' } },
          { '🧛 ', { 'white', 'black' } },
      },

      always_active = true,
      show_last_status = true,
  }

  local explorer = {
      filetypes = { 'fern', 'NvimTree', 'lir' },
      active = {
          { '  ', { 'black', 'red' } },
          { helper.separators.slant_right, { 'red', 'NormalBg' } },
          { b_components.divider, '' },
          { b_components.file_name(''), { 'white', 'NormalBg' } },
      },
      always_active = true,
      show_last_status = true,
  }

  basic.lsp_name = {
      width = breakpoint_width,
      name = 'lsp_name',
      hl_colors = {
          magenta = { 'magenta', 'black' },
      },
      text = function(bufnr)
          if lsp_comps.check_lsp(bufnr) then
              return {
                  { lsp_comps.lsp_name(), 'magenta' },
              }
          end
          return {
              { b_components.cache_file_type({icon = true}), 'magenta' },
          }
      end,
  }

  local default = {
      filetypes = { 'default' },
      active = {
          basic.square_mode,
          basic.vi_mode,
          basic.file,
          basic.lsp_diagnos,
          basic.divider,
          basic.file_right,
          basic.lsp_name,
          basic.git,
          { git_comps.git_branch(), { 'magenta', 'black' }, breakpoint_width },
          { ' ', hl_list.Black },
          basic.square_mode,
      },
      inactive = {
          { b_components.full_file_name, hl_list.Inactive },
          basic.file_name_inactive,
          basic.divider,
          basic.divider,
          { b_components.line_col, hl_list.Inactive },
          { b_components.progress, hl_list.Inactive },
      },
  }

  windline.setup({
      colors_name = function(colors)
          -- print(vim.inspect(colors))
          -- ADD MORE COLOR HERE ----
          return colors
      end,
      statuslines = {
          default,
          quickfix,
          explorer,
      },
  })
  require('github-theme').setup()
  require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
  require("nvim-treesitter.configs").setup{
  rainbow = {
    enable = true,
    colors = {
        "#68a0b0",
        "#946EaD",
        "#c7aA6D",
        },
    disable = { "html" },
    }
  }
  require('gitsigns').setup {
    signs = {
      add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
      change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
      follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
    yadm = {
      enable = false
    },
  }
  require("neo-tree").setup({
          close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
          popup_border_style = "rounded",
          enable_git_status = true,
          enable_diagnostics = true,
          sort_case_insensitive = false, -- used when sorting files and directories in the tree
          sort_function = nil , -- use a custom function for sorting files and directories in the tree
          -- sort_function = function (a,b)
          --       if a.type == b.type then
          --           return a.path > b.path
          --       else
          --           return a.type > b.type
          --       end
          --   end , -- this sorts files and directories descendantly
          default_component_configs = {
            container = {
              enable_character_fade = true
            },
            indent = {
              indent_size = 2,
              padding = 1, -- extra padding on left hand side
              -- indent guides
              with_markers = true,
              indent_marker = "│",
              last_indent_marker = "└",
              highlight = "NeoTreeIndentMarker",
              -- expander config, needed for nesting files
              with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
              expander_collapsed = "",
              expander_expanded = "",
              expander_highlight = "NeoTreeExpander",
            },
            icon = {
              folder_closed = "",
              folder_open = "",
              folder_empty = "ﰊ",
              -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
              -- then these will never be used.
              default = "*",
              highlight = "NeoTreeFileIcon"
            },
            modified = {
              symbol = "[+]",
              highlight = "NeoTreeModified",
            },
            name = {
              trailing_slash = false,
              use_git_status_colors = true,
              highlight = "NeoTreeFileName",
            },
            git_status = {
              symbols = {
                -- Change type
                added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                deleted   = "✖",-- this can only be used in the git_status source
                renamed   = "",-- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored   = "",
                unstaged  = "",
                staged    = "",
                conflict  = "",
              }
            },
          },
          window = {
            position = "left",
            width = 25,
            mapping_options = {
              noremap = true,
              nowait = true,
            },
            mappings = {
              ["<space>"] = {
                  "toggle_node",
                  nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
              },
              ["<2-LeftMouse>"] = "open",
              ["<cr>"] = "open",
              ["S"] = "open_split",
              ["s"] = "open_vsplit",
              -- ["S"] = "split_with_window_picker",
              -- ["s"] = "vsplit_with_window_picker",
              ["t"] = "open_tabnew",
              ["w"] = "open_with_window_picker",
              ["C"] = "close_node",
              ["a"] = {
                "add",
                -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                config = {
                  show_path = "none" -- "none", "relative", "absolute"
                }
              },
              ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
              ["d"] = "delete",
              ["r"] = "rename",
              ["y"] = "copy_to_clipboard",
              ["x"] = "cut_to_clipboard",
              ["p"] = "paste_from_clipboard",
              ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
              -- ["c"] = {
              --  "copy",
              --  config = {
              --    show_path = "none" -- "none", "relative", "absolute"
              --  }
              --}
              ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
              ["q"] = "close_window",
              ["R"] = "refresh",
              ["?"] = "show_help",
            }
          },
          nesting_rules = {},
          filesystem = {
            filtered_items = {
              visible = true, -- when true, they will just be displayed differently than normal items
              hide_dotfiles = true,
              hide_gitignored = true,
              hide_hidden = true, -- only works on Windows for hidden files/directories
              hide_by_name = {
                --"node_modules"
              },
              hide_by_pattern = { -- uses glob style patterns
                --"*.meta"
              },
              never_show = { -- remains hidden even if visible is toggled to true
                --".DS_Store",
                --"thumbs.db"
              },
            },
            follow_current_file = true, -- This will find and focus the file in the active buffer every
                                        -- time the current file is changed while the tree is open.
            group_empty_dirs = false, -- when true, empty folders will be grouped together
            hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                                    -- in whatever position is specified in window.position
                                  -- "open_current",  -- netrw disabled, opening a directory opens within the
                                                    -- window like netrw would, regardless of window.position
                                  -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
            use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                            -- instead of relying on nvim autocmd events.
            window = {
              mappings = {
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["H"] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["f"] = "filter_on_submit",
                ["<c-x>"] = "clear_filter",
                ["[g"] = "prev_git_modified",
                ["]g"] = "next_git_modified",
              }
            }
          },
          buffers = {
            follow_current_file = true, -- This will find and focus the file in the active buffer every
                                        -- time the current file is changed while the tree is open.
            group_empty_dirs = true, -- when true, empty folders will be grouped together
            show_unloaded = true,
            window = {
              mappings = {
                ["bd"] = "buffer_delete",
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
              }
            },
          },
          git_status = {
            window = {
              position = "float",
              mappings = {
                ["A"]  = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
                ["gc"] = "git_commit",
                ["gp"] = "git_push",
                ["gg"] = "git_commit_and_push",
              }
            }
          }
        })
  vim.opt.list = true
  -- vim.opt.listchars:append("space:·")
  -- vim.opt.listchars:append("space:•")
  -- vim.opt.listchars:append("eol:↴")
  require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    }
  require("zen-mode").setup {
    window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 120, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
          },
        },
    plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          },
        twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = false }, -- disables the tmux statusline
        -- this will change the font size on kitty when in zen mode
        -- to make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        kitty = {
          enabled = false,
          font = "+4", -- font size increment
          },
        },
    -- callback where you can add custom code when the Zen window opens
    on_open = function(win)
    end,
    -- callback where you can add custom code when the Zen window closes
    on_close = function()
    end,
    }
  require("twilight").setup {
    dimming = {
        alpha = 0.25, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = { "Normal", "#ffffff" },
        inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
        },
    context = 10, -- amount of lines we will try to show around the current line
    treesitter = true, -- use treesitter when available for the filetype
    -- treesitter is used to automatically expand the visible text,
    -- but you can further control the types of nodes that should always be fully expanded
    expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
    "function",
    "method",
    "table",
    "if_statement",
    },
  exclude = {}, -- exclude these filetypes
  }
EOF

let g:UltiSnipsExpandTrigger = '<S-tab>'
augroup qs_colors
   autocmd!
   autocmd colorscheme * highlight quickscopeprimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
   autocmd colorscheme * highlight quickscopesecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup end

nnoremap s :%s//gc<left><left><left>

autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd filetype cpp ?solution
" autocmd filetype * :Twilight
autocmd FileType * :TSEnable highlight
autocmd FileType * :TSDisable indent
noremap <leader>p :-1r !xclip -o -sel clip<cr>
noremap <leader>y :'<,'>w !xclip -selection clipboard<cr><cr>

colorscheme github_*
" colorscheme dracula
" colorscheme onedarkpro
let g:vim_monokai_tasty_italic = 1                    " allow italics, set this before the colorscheme
" let g:neoformat_basic_format_align = 1
" let g:cpp_class_scope_highlight = 1
inoremap <silent><expr> <TAB>
         \ coc#pum#visible() ? coc#pum#next(1):
         \ <SID>check_back_space() ? "\<Tab>" :
         \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

autocmd insertleave * :set norelativenumber
autocmd insertenter * :set relativenumber

lua << EOF
require'nvim-treesitter.configs'.setup {
   indent = {
      enable = true
      }
   }
require'nvim-treesitter'.define_modules {
   my_cool_plugin = {
      attach = function(bufnr, lang)
      -- Do cool stuff here
      end,
      detach = function(bufnr)
      -- Undo cool stuff here
      end,
      is_supported = function(lang)
      -- Check if the language is supported
      end
      },
   rainbow = {
      enable = true,
      colors = {
         "#68a0b0",
         "#946EaD",
         "#c7aA6D",
         },
      disable = { "html" },
      }
   }
EOF

map <a-h> <c-w>h
map <a-j> <c-w>j
map <a-k> <c-w>k
map <a-l> <c-w>l
map H b
map L e
nnoremap <leader>jj /solution<cr>
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
au FocusLost * :wa
nnoremap <leader>ss :GhostSync<cr>
autocmd FileType c,h,cpp,hpp,json nnoremap <buffer> <silent> <leader>gh :ClangdSwitchSourceHeader<CR>
nnoremap <C-n> :NeoTreeFloatToggle<CR>
nnoremap <C-b> :NeoTreeFloatToggle buffers<CR>
let g:vim_current_word#highlight_twins = 1
" The word under cursor:
let g:vim_current_word#highlight_current_word = 1
let g:vim_current_word#highlight_only_in_focused_window = 1
let g:gitblame_enabled = 1
let g:nvim_tree_auto_open = 1 " will open the tree when the package is loaded.
let g:airline#extensions#tabline#enabled = 1
let g:AutoPairsFlyMode = 0
autocmd FileType * highlight rainbowcol1 guifg=#FF7B72 gui=bold
nnoremap <silent> f :HopWord<cr>







  " require("onedarkpro").setup{
  "   -- Theme can be overwritten with 'onedark' or 'onelight' as a string
  "   colors = {}, -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
  "   -- hlgroups = {}, -- Override default highlight groups
  "   -- filetype_hlgroups = {}, -- Override default highlight groups for specific filetypes
  "   plugins = { -- Override which plugins highlight groups are loaded
  "       native_lsp = true,
  "       polygot = true,
  "       treesitter = true,
  "       -- NOTE: Other plugins have been omitted for brevity
  "   },
  "   styles = {
  "       strings = "NONE", -- Style that is applied to strings
  "       comments = "italic", -- Style that is applied to comments
  "       keywords = "NONE", -- Style that is applied to keywords
  "       functions = "NONE", -- Style that is applied to functions
  "       variables = "NONE", -- Style that is applied to variables
  "       virtual_text = "italic", -- Style that is applied to virtual text
  "   },
  "   options = {
  "       bold = false, -- Use the themes opinionated bold styles?
  "       italic = true, -- Use the themes opinionated italic styles?
  "       underline = false, -- Use the themes opinionated underline styles?
  "       undercurl = true, -- Use the themes opinionated undercurl styles?
  "       cursorline = true, -- Use cursorline highlighting?
  "       transparency = false, -- Use a transparent background?
  "       terminal_colors = false, -- Use the theme's colors for Neovim's :terminal?
  "       window_unfocused_color = true, -- When the window is out of focus, change the normal background?
  "   }
  " }

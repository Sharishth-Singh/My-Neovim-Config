let mapleader=" "
set tabstop=4
set shiftwidth=3
set expandtab
set hidden
set scrolloff=10
set ai
set si
set ignorecase
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
" let s:fontsize = 16
" autocmd GuiFont Hack:h18
" autocmd BufWritePre * %s/\s\+$//e
" autocmd BufWritePre * %s/\n\+\%$//e

call plug#begin('~/.local/share/nvim/plugged')
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
Plug 'projekt0n/github-nvim-theme' " theme
Plug 'vim-airline/vim-airline' " the statusbar
Plug 'yggdroot/indentline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'jiangmiao/auto-pairs'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
Plug 'tpope/vim-commentary'
Plug 'folke/twilight.nvim'
Plug 'folke/zen-mode.nvim'
call plug#end()

lua << EOF
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
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
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
          width = 40,
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
            visible = false, -- when true, they will just be displayed differently than normal items
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
          follow_current_file = false, -- This will find and focus the file in the active buffer every
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
vim.opt.listchars:append("space:·")
-- vim.opt.listchars:append("space:•")
vim.opt.listchars:append("eol:↴")
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
      twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
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
EOF
lua << EOF
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

nnoremap s :%s//gc<left><left>

autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd filetype cpp /solution
autocmd filetype * :Twilight
autocmd FileType * :TSEnable highlight
autocmd FileType * :TSDisable indent
noremap <leader>p :-1r !xclip -o -sel clip<cr>
noremap <leader>y :'<,'>w !xclip -selection clipboard<cr><cr>

" colorscheme github_*
colorscheme dracula
let g:vim_monokai_tasty_italic = 1                    " allow italics, set this before the colorscheme
" let g:neoformat_basic_format_align = 1 " let g:cpp_class_scope_highlight = 1
" function! s:check_back_space() abort
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~ '\s'
" endfunction

" inoremap <silent><expr> <tab>
"          \ pumvisible() ? "\<c-n>" :
"          \ <sid>check_back_space() ? "\<tab>" :
"          \ coc#refresh()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif


" let g:cursorword_min_width = 1
" let g:cursorword_max_width = 50

" hi default cursorword cterm=underline gui=underline

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
      }
   }
EOF


" require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
" auto_reload_on_write = true,
" create_in_closed_folder = false,
" disable_netrw = false,
" hijack_cursor = false,
" hijack_netrw = true,
" hijack_unnamed_buffer_when_opening = false,
" ignore_buffer_on_setup = false,
" open_on_setup = false,
" open_on_setup_file = false,
" open_on_tab = false,
" sort_by = "name",
" update_cwd = false,
" reload_on_bufenter = false,
" respect_buf_cwd = false,
" view = {
"    adaptive_size = false,
"    centralize_selection = false,
"    width = 30,
"    height = 30,
"    hide_root_folder = false,
"    side = "right",
"    preserve_window_proportions = true,
"    number = false,
"    relativenumber = false,
"    signcolumn = "yes",
"    mappings = {
"       custom_only = false,
"       list = {
"          -- user mappings go here
"          },
"       },
"    },
" renderer = {
"    add_trailing = false,
"    group_empty = false,
"    highlight_git = true,
"    full_name = false,
"    highlight_opened_files = "none",
"    root_folder_modifier = ":~",
"    indent_markers = {
"       enable = false,
"       icons = {
"          corner = "└ ",
"          edge = "│ ",
"          item = "│ ",
"          none = "  ",
"          },
"       },
"    icons = {
"       webdev_colors = true,
"       git_placement = "before",
"       padding = " ",
"       symlink_arrow = " ➛ ",
"       show = {
"          file = true,
"          folder = true,
"          folder_arrow = true,
"          git = true,
"          },
"       glyphs = {
"          default = "",
"          symlink = "",
"          folder = {
"             arrow_closed = "",
"             arrow_open = "",
"             default = "",
"             open = "",
"             empty = "",
"             empty_open = "",
"             symlink = "",
"             symlink_open = "",
"             },
"          git = {
"             unstaged = "✗",
"             staged = "✓",
"             unmerged = "",
"             renamed = "➜",
"             untracked = "★",
"             deleted = "",
"             ignored = "◌",
"             },
"          },
"       },
"    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
"    },
" hijack_directories = {
"    enable = true,
"    auto_open = true,
"    },
" update_focused_file = {
"    enable = false,
"    update_cwd = false,
"    ignore_list = {},
"    },
" ignore_ft_on_setup = {},
" system_open = {
"    cmd = "",
"    args = {},
"    },
" diagnostics = {
"    enable = false,
"    show_on_dirs = false,
"    icons = {
"       hint = "",
"       info = "",
"       warning = "",
"       error = "",
"       },
"    },
" filters = {
"    dotfiles = false,
"    custom = {},
"    exclude = {},
"    },
" filesystem_watchers = {
"    enable = false,
"    interval = 100,
"    },
" git = {
"    enable = true,
"    ignore = true,
"    timeout = 400,
"    },
" actions = {
"    use_system_clipboard = true,
"    change_dir = {
"       enable = true,
"       global = false,
"       restrict_above_cwd = false,
"       },
"    expand_all = {
"       max_folder_discovery = 300,
"       },
"    open_file = {
"       quit_on_open = false,
"       resize_window = true,
"       window_picker = {
"          enable = true,
"          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
"          exclude = {
"             filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
"             buftype = { "nofile", "terminal", "help" },
"             },
"          },
"       },
"    remove_file = {
"       close_window = true,
"       },
"    },
" trash = {
"    cmd = "gio trash",
"    require_confirm = true,
"    },
" live_filter = {
"    prefix = "[FILTER]: ",
"    always_show_folders = true,
"    },
" log = {
"    enable = false,
"    truncate = false,
"    types = {
"       all = false,
"       config = false,
"       copy_paste = false,
"       diagnostics = false,
"       git = false,
"       profile = false,
"       watcher = false,
"       },
"    },
" } -- END_DEFAULT_OPTS



" require'nvim-treesitter.configs'.setup {
"   rainbow = {
"     enable = true
"   }
" }
autocmd insertleave * :%s/\s\+$//e
map <a-h> <c-w>h
map <a-j> <c-w>j
map <a-k> <c-w>k
map <a-l> <c-w>l
"let g:airline_theme = 'onehalfdark'
let g:airline_theme = 'dracula'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
         \ quit | endif
au FocusLost * :wa
nnoremap <leader>jj /solution<cr>
autocmd FileType c,h,cpp,hpp,json nnoremap <buffer> <silent> <leader>gh :ClangdSwitchSourceHeader<CR>
nnoremap <C-n> :NeoTreeFloatToggle<CR>
nnoremap <C-b> :NeoTreeFloatToggle buffers<CR>
" nnoremap <leader>r :NvimTreeRefresh<CR>
" nnoremap <leader>n :NvimTreeFindFile<CR>
" nnoremap <silent>ff :Neoformat<cr>
" let g:neoformat_run_all_formatters = 1
" highlight NvimTreeFolderIcon guibg=blue
" Twins of word under cursor:
let g:vim_current_word#highlight_twins = 1
" The word under cursor:
let g:vim_current_word#highlight_current_word = 1
let g:vim_current_word#highlight_only_in_focused_window = 1
let g:gitblame_enabled = 1
" hi CurrentWord guifg=#000000 guibg=#444444
" hi CurrentWordTwins guibg=#444444
let g:nvim_tree_auto_open = 1 " will open the tree when the package is loaded.
" let g:indentLine_char = '❯'

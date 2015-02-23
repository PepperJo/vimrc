

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Amir Salihefendic
"       http://amix.dk - amix@amix.dk
"
" Version: 
"       5.0 - 29/05/12 15:43:36
"
" Blog_post: 
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
"
" Raw_version: 
"       http://amix.dk/vim/vimrc.txt
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vim_addon_manager = {}
let g:vim_addon_manager.shell_commands_run_method='system'

fun! SetupVAM()
    let c = get(g:, 'vim_addon_manager', {})
    let g:vim_addon_manager = c
    let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
    let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
    if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
        execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \ shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
    endif
    call vam#ActivateAddons([], {'auto_install' : 0})
endfun

call SetupVAM()
" use <c-x><c-p> to complete plugin names

VAMActivate github:bling/vim-airline
VAMActivate github:Valloric/YouCompleteMe
VAMActivate molokai
VAMActivate trailing-whitespace
VAMActivate ctrlp
VAMActivate github:scrooloose/nerdtree
VAMActivate github:sjl/gundo.vim
" VAMActivate fugitive (git)
VAMActivate delimitMate
VAMActivate Tabular
VAMActivate ag
VAMActivate EasyMotion
VAMActivate tComment
VAMActivate github:martong/vim-compiledb-path
VAMActivate github:LaTeX-BoX-Team/LaTeX-Box

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPBuffer'

nnoremap <c-p><c-p> :CtrlP<CR>

let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ag
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <F2> :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-compiledb-path
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup Enter
    autocmd!
    autocmd VimEnter * :CompileDbPathIfExists ./compile_commands.json
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YCM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_global_ycm_extra_conf = '~/Documents/ycm-conf/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_always_populate_location_list = 1 "default 0
let g:ycm_open_loclist_on_ycm_diags = 1 "default 1

let g:ycm_total_in_strings = 1 "default 1

let g:ycm_semantic_triggers = {
    \   'c' : ['->', '.'],
    \   'objc' : ['->', '.'],
    \   'ocaml' : ['.', '#'],
    \   'cpp,objcpp' : ['->', '.', '::'],
    \   'perl' : ['->'],
    \   'php' : ['->', '::'],
    \   'cs,java,javascript,d,python,perl6,scala,vb,elixir,go' : ['.'],
    \   'vim' : ['re![_a-zA-Z]+[_\w]*\.'],
    \   'ruby' : ['.', '::'],
    \   'lua' : ['.', ':'],
    \   'erlang' : [':'],
    \   'tex' : ['{']
    \ }

"let g:ycm_autoclose_preview_window_after_completion = 1

let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
let g:ycm_server_log_level = 'info' "default info"

let g:ycm_extra_conf_vim_data =  ['getcwd()']

nnoremap <F3> :YcmCompleter GoToDefinitionElseDeclaration<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Gundo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gundo_right = 1
let g:gundo_width = 60
let g:gundo_preview_height = 30

nnoremap <F5> :GundoToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NerdTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:NERDTreeWinPos = 'right'
let g:NERDTreeWinSize = 60

noremap <F6> :NERDTreeToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on the WiLd menu
set wildmode=longest:full
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set mouse=a " enable mouse for all modes settings
set nomousehide " don't hide the mouse cursor while typing
set mousemodel=popup " right-click pops up context menu

set cursorline " highlight the current line
set cursorcolumn

set number " enable line numbers

nnoremap d "_d

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

colorscheme molokai

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set writebackup
set nobackup

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

vnoremap < <gv
vnoremap > >gv

" Usefull scripts
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 80 character line highlight
let &colorcolumn = 81
highlight ColorColumn ctermbg=235 guibg=#2c2d27


" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


" => Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set pastetoggle=<F2>


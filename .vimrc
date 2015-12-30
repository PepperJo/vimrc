"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This vimrc was created out of various source:
" - http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
" - https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
" - http://vim.wikia.com/wiki/Automatic_insertion_of_C/C%2B%2B_header_gates
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
VAMActivate github:tomasr/molokai
VAMActivate github:bronson/vim-trailing-whitespace
VAMActivate github:kien/ctrlp.vim
VAMActivate github:sjl/gundo.vim
VAMActivate github:Raimondi/delimitMate
VAMActivate github:godlygeek/tabular
VAMActivate github:rking/ag.vim
VAMActivate github:easymotion/vim-easymotion
VAMActivate github:tomtom/tcomment_vim
VAMActivate github:LaTeX-BoX-Team/LaTeX-Box
VAMActivate LargeFile
VAMActivate github:google/vim-codefmt

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => delimitMate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:delimitMate_expand_cr = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CodeFmt
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:codefmt_clang_format_style = "{BasedOnStyle: LLVM, IndentWidth: 4, PointerAlignment: Left}"

let g:auto_format_toggle = 0
function! ToggleAutoformat()
    let g:auto_format_toggle = !g:auto_format_toggle
    if g:auto_format_toggle
        echo "Autoformat on buffer write: enabled"
        :AutoFormatBuffer
    else
        echo "Autoformat on buffer write: disabled"
        :NoAutoFormatBuffer
    endif
endfunction
command! AutoformatToggle call ToggleAutoformat()

nmap <C-k> :AutoformatToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => LaTeX-BoX
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:LatexBox_custom_indent = 0

" textwidth 80
autocmd bufreadpre *.tex setlocal textwidth=80

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
            \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
            \}

let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ag
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ctrl+/
nnoremap <C-_> :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>

let g:ag_working_path_mode='r'
let g:ag_highlight=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Display status line always
set laststatus=2

let g:airline_powerline_fonts = 1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YCM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_global_ycm_extra_conf = '~/Source/ycm-conf/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_always_populate_location_list = 1 "default 0
let g:ycm_open_loclist_on_ycm_diags = 1 "default 1

let g:ycm_total_in_strings = 1 "default 1

"let g:ycm_autoclose_preview_window_after_completion = 1

let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
let g:ycm_server_log_level = 'info' "default info"

let g:ycm_extra_conf_vim_data_root_dir = getcwd()
let g:ycm_extra_conf_vim_data_explore = ['.']
let g:ycm_extra_conf_vim_data =  ['g:ycm_extra_conf_vim_data_root_dir', 'g:ycm_extra_conf_vim_data_explore']

nnoremap <C-h> :YcmCompleter GoTo<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Gundo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gundo_right = 1
let g:gundo_width = 60
let g:gundo_preview_height = 30

nnoremap <C-u><C-u> :GundoToggle<CR>

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

nnoremap <C-Left> :bprev <CR>
nnoremap <C-Right> :bnext <CR>

set clipboard=unnamedplus

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => HexMode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        silent :e " this will reload the file without trickeries
        "(DOS line endings will be shown entirely )
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif
    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C/C++ header gates
""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:insert_gates()
    let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    execute "normal! i#ifndef " . gatename
    execute "normal! o#define " . gatename
    execute "normal! Go#endif /* " . gatename . " */"
    normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()


function! IsWindows()
    return has("win32") || has("win64") || has("win32unix")
endfunction

function! IsLinux()
    return has("unix") || !IsWindows()
endfunction

function! IsCDNSVMHost()
    return hostname() == "cva-mp86"
                \ || hostname() == "vlsj-anhong"
                \ || hostname() == "sjcvl-anhong"
endfunction

function! IsCDNSHost()
    return IsCDNSVMHost()
                \ || hostname() =~ "hsv-sc.*$"
                \ || hostname() =~ "hsv-sw.*$"
                \ || hostname() =~ "hsv-bw.*$"
                \ || hostname() =~ "cva-mp.*$"
                \ || hostname() =~ "hsv-smd.*$"
                \ || hostname() =~ "cva-xeon.*$"
endfunction

function! IsWSLHost()
    return hostname() =~ "PC-ANHONG2"
endfunction

function! IsP4Enabled()
    return !empty($P_HOME)
endfunction

if IsWindows()
    let g:python3_host_prog = 'C:\Users\anhong\AppData\Local\Programs\Python\Python311\python.exe'
endif

" ================
" vim-plug setup
" ================

" nvim:
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

" Specify a directory for plugins
call plug#begin(stdpath('data').'/plugged')

" Make sure you use single quotes

" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}
" Plug 'WolfgangMehner/c-support'
" Plug 'sbdchd/neoformat'
Plug 'dstein64/vim-startuptime'
Plug 'godlygeek/tabular'
Plug 'windwp/nvim-autopairs'
Plug 'luochen1990/rainbow'
Plug 'farmergreg/vim-lastplace'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sukima/xmledit'
Plug 'etorth/PyGithubDiary'
Plug 'tomtom/tcomment_vim'
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'vim-scripts/VisIncr'
Plug 'vim-scripts/a.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-lua-ftplugin'
Plug 'tpope/vim-surround'
Plug 'hrsh7th/vim-unmatchparen'
Plug 'msgpack/msgpack-python'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'liuchengxu/vim-which-key'
Plug 'chrisbra/csv.vim'
Plug 'github/copilot.vim'
Plug 'dracula/vim', {'as': 'dracula'}

call plug#end()

set number
set autoindent
set noswapfile
set cindent
set nobackup
set expandtab
set smartindent
set showcmd
set lazyredraw
set nowritebackup
set noswapfile
set wildmenu
set noerrorbells
set novisualbell
set visualbell
set hlsearch
set cursorline
set cursorcolumn

set fileformat    =unix
set tabstop       =4
set shiftwidth    =4
set backspace     =2
set textwidth     =0
set showtabline   =0
set laststatus    =2
set mouse         =
set selectmode    =key
set display       =lastline
set t_vb          =
set t_Co          =256
set history       =400
set scrolloff     =9999
set sidescrolloff =9999
set sidescroll    =1
set tags         +=./tags
set spelllang    +=cjk

nmap \r             :.-1r!
map j               gj
map k               gk
map H               ^
map L               $
map <F1>            <NOP>
map <UP>            <NOP>
map <DOWN>          <NOP>
map <LEFT>          <NOP>
map <RIGHT>         <NOP>
map <LeftMouse>     <NOP>
map <LeftDrag>      <NOP>
map <LeftRelease>   <NOP>
map <MiddleMouse>   <NOP>
map <MiddleDrag>    <NOP>
map <MiddleRelease> <NOP>
map <RightMouse>    <NOP>
map <RightDrag>     <NOP>
map <RightRelease>  <NOP>

imap <F1>           <NOP>
imap <UP>           <NOP>
imap <DOWN>         <NOP>
imap <LEFT>         <NOP>
imap <RIGHT>        <NOP>

map         gf      :sp <cfile><cr>
nnoremap    <C-J>   :bn<cr>
nnoremap    <C-K>   :bp<cr>

autocmd BufEnter *.hpp set foldmethod=indent
autocmd BufEnter *.c   set foldmethod=indent
autocmd BufEnter *.h   set foldmethod=indent
autocmd BufEnter *.sh  set foldmethod=indent

autocmd BufEnter *.hpp set nowrap
autocmd BufEnter *.h   set nowrap
autocmd BufEnter *.cpp set nowrap
autocmd BufEnter *.c   set nowrap
autocmd BufEnter *.C   set nowrap
autocmd BufEnter *.sh  set nowrap

syntax      on
filetype    plugin on
filetype    indent on

autocmd BufEnter *.txt set spell
autocmd BufEnter *.tex set spell
autocmd BufEnter *.C   set filetype=cpp
autocmd BufEnter *.fl  set filetype=cpp
autocmd BufEnter *.qel set filetype=tcl
autocmd BufEnter *.xel set filetype=tcl

autocmd BufRead,BufNewFile  *.h  set filetype=cpp

lua << EOF
require("nvim-autopairs").setup {}
EOF

if has("conceal")
    set conceallevel=0
endif

highlight Folded guibg=grey guifg=blue
highlight Folded ctermfg=5 ctermbg=0
highlight FoldColumn guibg=darkgrey guifg=white

" rainbow configuration
" set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1

if IsLinux()
    set undodir=$HOME/.vimundo
    set undofile

    set t_Co        =256
    set tabstop     =8
    set t_kd        =OA
    set t_ku        =OB
    set t_kr        =OC
    set t_kl        =OD
elseif IsWindows()
    set undodir=$HomePath/.vimundo
    set undofile
endif

if IsWSLHost()
    let g:copilot_node_command = "/home/anhong/node-v17.9.1-linux-x64/bin/node"
elseif IsCDNSHost()
    let g:copilot_node_command = "/grid/common/pkgs/node/v16.15.0/bin/node"
else
    let g:copilot_node_command = "C:\\Program\ Files\\nodejs\\node.exe"
endif

imap <silent><script><expr> <C-n> copilot#Accept("")
let g:copilot_no_tab_map = v:true

if IsP4Enabled()
    let &makeprg="gmake -j 32 debug-install SYSTRG=64bit"
else
    let &makeprg="make -j 4"
endif

function! Tailf()
    if (len(expand('%:p')) > 0) && (&modified == 0)
        e
    endif

    norm G
    norm 0
    redraw
endfunction
map <silent> T <ESC>:call Tailf()<CR><ESC>

function! IgnoreSpaceDiff()
    if &diff
        set diffopt+=iwhite
    else
        echohl ErrorMsg | echo "Not in diff mode!" | echohl None
    endif
endfunction
command! IgnoreSpaceDiff :call IgnoreSpaceDiff()

function! TabSpace2()
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
endfunction
command! TabSpace2 :call TabSpace2()

function! DiffWithSavedFunc()
    let l:filetype=&ft
    diffthis
    vnew | read # | normal! 1Gdd
    diffthis
    execute "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . l:filetype
endfunction
command! DiffWithSaved call DiffWithSavedFunc()

" highlight current line with cursor *permanently*
let g:permanent_hightlighting_selected_line = 0
let g:permanent_highlight_line = 0
function! PermanentHighlightingFunc()
    " 1. exit current mode back to normal mode
    "    currently only visual mode can get here
    " :norm \<ESC>

    " 2. setup to select current line permanently
    if g:permanent_hightlighting_selected_line == 1 && g:permanent_highlight_line == line('.')
        execute ':match'
        let g:permanent_hightlighting_selected_line = 0
        let g:permanent_highlight_line = 0
    else
        execute ':match Search /\%'.line('.').'l/'
        let g:permanent_hightlighting_selected_line = 1
        let g:permanent_highlight_line = line('.')
    endif
endfunction
xnoremap <silent> <CR> <ESC>:call PermanentHighlightingFunc()<CR>

" use space key to highlight pattern under the cursor currently
let g:highlighting_under_cursor = 0
function! HighlightingUnderCursor()

    if g:highlighting_under_cursor == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
        let g:highlighting_under_cursor = 0
        return ":silent nohlsearch\<CR>"
    endif

    " if g:highlighting_under_cursor == 1
    "     let g:highlighting_under_cursor = 0
    "     let @/ = ""
    "     return ":silent set nohlsearch\<CR>"
    " endif

    let @/ = '\<'.expand('<cword>').'\>'
    let g:highlighting_under_cursor = 1
    return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> <SPACE> HighlightingUnderCursor()

" use cdpath to edit file
" edit file can now seach path list in $VIM_CDPATH
" function! FindInCDPath(name)
"     let path_backup = &path
"     if empty(&path)
"         let &path = join(split($VIM_CDPATH), ',')
"     else
"         let &path = &path . "," . join(split($VIM_CDPATH), ',')
"     endif
"
"     setlocal bufhidden=wipe
"     execute 'silent keepalt find ' . fnameescape(a:name)
"     let &path = path_backup
"     set bufhidden<
" endfunction

if IsCDNSVMHost()
    " don't use deoplete
    " no python support for basic version
else
    set pyxversion =3
    let g:deoplete#enable_at_startup = 1
    " let g:deoplete#enable_smart_case = 1
    call deoplete#custom#option({
    \ 'auto_complete_delay': 200,
    \ 'smart_case': v:true,
    \ })
endif

let g:alternateExtensions_C = "h,hpp,H,HPP"
let g:alternateExtensions_h = "c,cpp,cxx,cc,CC,C,CPP,CXX"

let g:dracula_high_contrast_diff = 1
colorscheme dracula

" Trailing whitespaces:
" highlight all trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" remove all trailing whitespaces
nnoremap <silent> <leader>ds :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" LSP config
" currently use clangd, may also try ccls, check: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
"
" lua << EOF
" require'lspconfig'.clangd.setup{
"     cmd = {"clangd-11", "--background-index", "--compile-commands-dir=/home/anhong/b"},
" }
" EOF

" config for LeaderF
" gui interface is implemented by vim-which-key

let g:Lf_HideHelp = 1
let g:Lf_UseCache = 1
let g:Lf_FollowLinks = 1
let g:Lf_ShowDevIcons = 0
let g:Lf_PreviewInPopup = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_CommandMap = {'<C-J>': ['<C-N>'], '<C-K>': ['<C-P>']}

function! SearchP4Client() abort
    let g:Lf_RootMarkers = ['.P4Config', '.P4ignore', '.p4ignore']
    let g:Lf_WorkingDirectoryMode = 'a'
    Leaderf file
endfunction

function! SearchGitRepo() abort
    let g:Lf_RootMarkers = ['.git']
    let g:Lf_WorkingDirectoryMode = 'a'
    Leaderf file
endfunction

" cmake support for LeaderF
" find the configured source dir: https://stackoverflow.com/questions/27188786/find-source-directory-from-build-directory-in-cmake
function! SearchCmakeSourceDir() abort
    if filereadable("CMakeCache.txt")
        for line in readfile("CMakeCache.txt")
            let foundDirLine = matchstr(line, '.*_SOURCE_DIR:STATIC=.*')
            let foundDir = matchstr(foundDirLine, '/.*')
            if !empty(foundDir)
                execute ':Leaderf file ' . foundDir
                return
            endif
        endfor
    endif
    Leaderf file
endfunction

" interface for LeaderF, using vim-which-key
" if want to build one by using float-window, check: https://www.statox.fr/posts/2021/03/breaking_habits_floating_window/
"
let g:which_key_centered = 1
let g:which_key_vertical = 1
let g:which_key_map = {}
let g:which_key_map['LeaderF'] = {
            \ 'name': '+LeaderF',
            \ 'b' : ['<cmd>LeaderfBuffer\<cr>',               'current-buffers'],
            \ 'f' : ['<cmd>Leaderf file\<cr>',                'current-directory'],
            \ 'g' : ['<cmd>call SearchGitRepo()\<cr>',        'git-repository'],
            \ 'p' : ['<cmd>call SearchP4Client()\<cr>',       'perforce-client'],
            \ 'c' : ['<cmd>call SearchCmakeSourceDir()\<cr>', 'cmake-source'],
            \ }
nnoremap <C-P> <cmd>WhichKey! g:which_key_map['LeaderF']<cr>

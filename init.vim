let g:isWin = has("win32") || has("win64") || has("win32unix")

" ================
" vim-plug setup
" ================

" nvim:
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

" Specify a directory for plugins
call plug#begin(stdpath('data').'/plugged')

" Make sure you use single quotes

Plug 'neovim/nvim-lspconfig'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'WolfgangMehner/c-support'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'mbbill/desertEx'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bfrg/vim-cpp-modern'
Plug 'sukima/xmledit'
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
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

set number
set wrap
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

syntax      on
filetype    plugin on
filetype    indent on

autocmd BufEnter *.txt set spell
autocmd BufEnter *.tex set spell
autocmd BufEnter *.fl  set filetype=cpp
autocmd BufEnter *.qel set filetype=tcl
autocmd BufEnter *.xel set filetype=tcl

function! BufReadPostFunc()
    if line("'\"") > 0 && line("'\"") <= line("$")
        exe "norm '\""
    else
        exe "norm $"
    endif
endfunction
autocmd BufReadPost * call BufReadPostFunc()

function! CreateCscopeDB()
    let s:strPath1 = expand("$PWD")
    let s:strPath2 = expand("%:p:h")
    let s:nRes1 = match(s:strPath1, s:strPath2)
    let s:nRes2 = match(s:strPath2, s:strPath1)

    let s:bFindSub = 0
    let s:strRootPath = s:strPath1
    if s:nRes1 == 0 || s:nRes2 == 0
        let s:bFindSub = 1
        if strlen(s:strPath1) > strlen(s:strPath2)
            let s:strRootPath = s:strPath2
        endif
    endif

    " this fucntion generate cscope db for current file
    if s:bFindSub == 0
        echoerr "file path doesn't agree with working path"
        return
    endif

    let s:Command = "find ".s:strRootPath
    let s:Command = s:Command." -name '*.cpp' "
    let s:Command = s:Command." -o "
    let s:Command = s:Command." -name '*.cxx' "
    let s:Command = s:Command." -o "
    let s:Command = s:Command." -name '*.CPP' "
    let s:Command = s:Command." -o "
    let s:Command = s:Command." -name '*.CXX' "
    let s:Command = s:Command." -o "
    let s:Command = s:Command." -name '*.C' "
    let s:Command = s:Command." -o "
    let s:Command = s:Command." -name '*.c' "
    let s:Command = s:Command." -o "
    let s:Command = s:Command." -name '*.hpp' "
    let s:Command = s:Command." -o "
    let s:Command = s:Command." -name '*.HPP' "
    let s:Command = s:Command." -o "
    let s:Command = s:Command." -name '*.h' "

    let s:Command = s:Command." > ".expand("$HOME")."/.cscope_db/cscope.files"

    execute "! ".s:Command
    execute "! cd ".expand("$HOME")."/.cscope_db && cscope -Rbq -i cscope.files && cd - > /dev/null"

    let s:CscopeCreatedDB = expand("$HOME")."/.cscope_db/cscope.out"
    if filereadable(s:CscopeCreatedDB)
        execute "silent cs add ".s:CscopeCreatedDB
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
" cscope -Rbq
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (has("cscope") && !has("win32") && !has("win64"))
    " Use both cscope and ctag
    set cscopetag
    " Show msg when cscope db added
    set cscopeverbose
    " Use tags for definition search first
    set cscopetagorder=1
    " Use quickfix window to show cscope results
    set cscopequickfix=s-,c-,d-,i-,t-,e-

    set csprg=/usr/bin/cscope
    set csto=1
    set cst
    set nocsverb
    " add any database in current directory
    " let s:CscopeDBName = expand("$PWD")."/.cscope_db/cscope.out"
    " if filereadable(s:CscopeDBName)
    "     execute "cs add ".s:CscopeDBName
    " endif
    set csverb

    nmap <C-\> :call CreateCscopeDB()<CR><CR>
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    " for CCTree
    let CCTreeEnhancedSymbolProcessing =1
    " let g:CCTreeOrientation            ="leftabove"
    if winwidth(0) < 100
        let CCTreeWindowVertical       =0
    endif
endif

autocmd BufRead,BufNewFile  *.h  set filetype=cpp
let g:C_SourceCodeExtensions  = 'h c cc cp cxx cpp CPP c++ C i ii'

" autopair config
let g:AutoPairsFlyMode = 0

if has("conceal")
    set conceallevel=0
endif

highlight Folded guibg=grey guifg=blue
highlight Folded ctermfg=5 ctermbg=0
highlight FoldColumn guibg=darkgrey guifg=white

" rainbow configuration
" set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1

function! IsWorkHost()
    return hostname() == "vlsj-anhong"
                \ || hostname() == "sjcvl-anhong"
                \ || hostname() =~ "hsv-sc.*$"
                \ || hostname() =~ "cva-xeon.*$"
                \ || hostname() =~ "hsv-sw.*$"
                \ || hostname() =~ "cva-mp.*$"
endfunction

function! IsWorkVM()
    return hostname() == "vlsj-anhong"
                \ || hostname() =~ "cva-mp.*$"
endfunction

if IsWorkHost()
    let g:UndoFileDir="$HOME"."/.vimundo"
    execute ":set undodir=".g:UndoFileDir
    set undofile

    set t_Co        =256
    set tabstop     =8
    " set shiftwidth
    set t_kd        = OA
    set t_ku        = OB
    set t_kr        = OC
    set t_kl        = OD
else
    let g:UndoFileDir="$HOME"."/Dropbox/.vimundo/".hostname()
    execute ":set undodir=".g:UndoFileDir
    set undofile
endif

function! CreateCrossLink()
    let s:strFileName = expand("%:p")
    if getftype(s:strFileName) == "file" && filereadable(s:strFileName) && filewritable(s:strFileName)
        let s:strNiceFileName = substitute(substitute(s:strFileName, "/", ".", "g"), "\\\\", ".", "g")
        " I have no idea why it's so slow
        call system("rm -rf $HOME/.cross_link && mkdir $HOME/.cross_link")
        call system("ln -s ".s:strFileName." $HOME/.cross_link/cross.".s:strNiceFileName)

        echo "symbol link created: ".expand("$HOME/.cross_link/").s:strNiceFileName
    else
        echoerr "can't create cross link file"
    endif
endfunction

if(hostname() == "vlsj-anhong" || hostname() =~ "hsv-sc.*$" || hostname() =~ "cva-xeon.*$" || hostname() =~ "hsv-sw.*$")
    let g:UndoFileDir="$HOME"."/.vimundo"
    execute ":set undodir=".g:UndoFileDir
    set undofile

    set t_Co        =256
    set tabstop     =8
    " set shiftwidth
    set t_kd        = OA
    set t_ku        = OB
    set t_kr        = OC
    set t_kl        = OD

    " autocmd BufReadPre * call CreateCrossLink()
    " autocmd BufNewFile * call CreateCrossLink()
    command! CrossLink call CreateCrossLink()

    " set makeprg=clearmake\ SYSTRG=64bit\ debug_install
    " let &makeprg="clearmake SYSTRG=64bit debug_install"
    let &makeprg="gmake -j 32 debug-install SYSTRG=64bit"
else
    let &makeprg="make -j 4"
    let g:UndoFileDir="$HOME"."/Dropbox/.vimundo/".hostname()
    execute ":set undodir=".g:UndoFileDir
    set undofile
endif

function! s:AddCscopeDB()
    let s:CscopeDBName = expand("$HOME")."/.cscope_db/cscope.out"
    if filereadable(s:CscopeDBName)
        :execute ":cs add ".s:CscopeDBName
    endif
endfunction
command! CSAddDB :call s:AddCscopeDB()

function! s:IgnoreSpaceDiff()
    if &diff
        set diffopt+=iwhite
    else
        echohl ErrorMsg | echo "Not in diff mode!" | echohl None
    endif
endfunction
command! IgnoreSpaceDiff :call s:IgnoreSpaceDiff()

function! s:TabSpace2()
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
endfunction
command! TabSpace2 :call s:TabSpace2()

" self diff
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffS call s:DiffWithSaved()

" highlight current line with cursor *permanently*
let g:permanent_hightlighting = 0
let g:permanent_highlight_line = 0
function! PermanentHighlightingFunc()
    " 1. exit current mode back to normal mode
    "    currently only visual mode can get here
    " :norm \<ESC>

    " 2. setup to select current line permanently
    if g:permanent_hightlighting == 1 && g:permanent_highlight_line == line('.')
        execute ':match'
        let g:permanent_hightlighting = 0
        let g:permanent_highlight_line = 0
    else
        execute ':match Search /\%'.line('.').'l/'
        let g:permanent_hightlighting = 1
        let g:permanent_highlight_line = line('.')
    endif
endfunction
xnoremap <silent> <CR> <ESC>:call PermanentHighlightingFunc()<CR>

" use space key to highlight pattern under the cursor currently
let g:highlighting = 0
function! HighlightingFunc()

    if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
        let g:highlighting = 0
        return ":silent nohlsearch\<CR>"
    endif

    " if g:highlighting == 1
    "     let g:highlighting = 0
    "     let @/ = ""
    "     return ":silent set nohlsearch\<CR>"
    " endif

    let @/ = '\<'.expand('<cword>').'\>'
    let g:highlighting = 1
    return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> <SPACE> HighlightingFunc()

" for fugitive Gdiff
" set diffopt+=vertical
if !exists(":Gdiffoff")
    command Gdiffoff diffoff | q | Gedit
endif

" use cdpath to edit file
" edit file can now seach path list in $VIM_CDPATH
function! FindInCDPath(name)
    let path_backup = &path
    if empty(&path)
        let &path = join(split($VIM_CDPATH), ',')
    else
        let &path = &path . "," . join(split($VIM_CDPATH), ',')
    endif

    setlocal bufhidden=wipe
    execute 'silent keepalt find ' . fnameescape(a:name)
    let &path = path_backup
    set bufhidden<
endfunction

" if !empty($VIM_CDPATH)
"     autocmd BufNewFile * nested call FindInCDPath(expand('<afile>'))
" endif

" " config for leaderF
" " still uses ctrlp shortkey
" let g:Lf_ShortcutF = '<C-P>'
" let g:Lf_FollowLinks = 1
" let g:Lf_PreviewInPopup = 1
" let g:Lf_WindowPosition = 'popup'
" let g:Lf_CommandMap = {'<C-J>': ['<C-N>'], '<C-K>': ['<C-P>']}
" " let g:Lf_DefaultMode = 'NameOnly'
" if !empty($P_HOME)
"     " let g:Lf_WorkingDirectory = $P_HOME
"     let g:Lf_RootMarkers = ['.P4Config', '.P4ignore']
"     let g:Lf_WorkingDirectoryMode = 'a'
" endif
"
" " cmake support for LeaderF
" " find the configured source dir: https://stackoverflow.com/questions/27188786/find-source-directory-from-build-directory-in-cmake
" if filereadable("CMakeCache.txt")
"     for line in readfile("CMakeCache.txt")
"         let foundDirLine = matchstr(line, '.*_SOURCE_DIR:STATIC=.*')
"         let foundDir = matchstr(foundDirLine, '/.*')
"         if !empty(foundDir)
"             let g:Lf_WorkingDirectory = foundDir
"         endif
"     endfor
" endif

nnoremap <C-P>f <cmd>Telescope find_files<cr>

if IsWorkVM()
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

colorscheme desertEx

" Trailing whitespaces:
" highlight all trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" remove all trailing whitespaces
nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

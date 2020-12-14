if (has("win32") || has("win64") || has("win32unix"))
    let g:isWin = 1
else
    let g:isWin = 0
endif

" ================
" vim-plug setup
" ================

" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'Shougo/deoplete.nvim'
Plug 'WolfgangMehner/c-support'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'mattn/vim-gist'
Plug 'mattn/webapi-vim'
Plug 'mbbill/desertEx'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'sukima/xmledit'
Plug 'tomtom/tcomment_vim'
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'vim-scripts/VisIncr'
Plug 'vim-scripts/a.vim'
Plug 'xolox/vim-lua-ftplugin'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'hrsh7th/vim-unmatchparen'
Plug 'etorth/timestamp.vim'
Plug 'msgpack/msgpack-python'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

" Initialize plugin system
call plug#end()

set nocompatible
"set wildignorecase
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
"set linebreak
set wildmenu
set noerrorbells
set novisualbell
set visualbell
set hlsearch

" set foldmethod  =marker
set foldmethod    =indent
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

" https://github.com/tpope/vim-fugitive
" make the quickfix window open after any grep invocation for fugitive
autocmd QuickFixCmdPost *grep* cwindow

autocmd BufNewFile,BufRead *.h      set nowrap
autocmd BufNewFile,BufRead *.c      set nowrap
autocmd BufNewFile,BufRead *.C      set nowrap
autocmd BufNewFile,BufRead *.cpp    set nowrap
autocmd BufNewFile,BufRead *.hpp    set nowrap
autocmd BufNewFile,BufRead *.m      set nowrap
autocmd BufNewFile,BufRead *.msg    set nowrap
autocmd BufNewFile,BufRead *.log    set nowrap
autocmd BufNewFile,BufRead *.key    set nowrap

autocmd BufEnter *.cpp set nospell
autocmd BufEnter *.hpp set nospell
autocmd BufEnter *.c   set nospell
autocmd BufEnter *.h   set nospell
autocmd BufEnter *.sh  set nospell

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

" map         gf      :tabnew <cfile><cr>
map         gf      :sp <cfile><cr>
nnoremap    <C-J>   :bn<cr>
nnoremap    <C-K>   :bp<cr>

" if &diff
"     colorscheme desertEx
"     finish
" endif

autocmd BufEnter *.hpp set foldmethod=indent 
autocmd BufEnter *.c   set foldmethod=indent 
autocmd BufEnter *.h   set foldmethod=indent 
autocmd BufEnter *.sh  set foldmethod=indent 

syntax      on
filetype    plugin on
filetype    indent on

" seems if use auto commands to setup the colorscheme
" vim-airline get issues
"
"  autocmd BufEnter *.cpp colorscheme desertEx
"  autocmd BufEnter *.hpp colorscheme desertEx
"  autocmd BufEnter *.c   colorscheme desertEx
"  autocmd BufEnter *.h   colorscheme desertEx
"  autocmd BufEnter *.sh  colorscheme desertEx
"  autocmd BufEnter *.tex colorscheme desertEx

autocmd BufEnter *.tex set spell
autocmd BufEnter *.fl  set filetype=cpp
autocmd BufEnter *.qel set filetype=tcl
autocmd BufEnter *.xel set filetype=tcl

function! MyWriteDiary()
    if(input("WRITE DIARY (Y/N):","Y") =~? "Y.*")

        " if( g:isWin == 1 )
        "     let s:DiaryName = $HOME."\\diary\\".strftime("%Y%m%d")
        " else
        "     let s:DiaryName = $HOME."/Dropbox/.diary/".strftime("%Y%m%d")
        " endif
        let s:DiaryName = $HOME."/Dropbox/.diary/".strftime("%Y%m%d")

    let s:passwordFileName = $HOME.'/.diary_password'
    if !filereadable(s:passwordFileName)
           echoerr 'cannot find password file: '.s:passwordFileName
       return
        endif

        let s:DiaryPWD = readfile(s:passwordFileName)[0]
        if !filereadable(s:DiaryName)
            exe ":tabnew ".s:DiaryName
            exe ":set key=".s:DiaryPWD
        else
            exe ":tabnew ".s:DiaryName
        endif

        exe ":norm G"
        let s:CurrentTimeIndex = "\n".strftime("%c").":"
        put =s:CurrentTimeIndex
        exe ":w"
    endif
endfunction
map <F12> <ESC>:call MyWriteDiary()<CR>


if(g:isWin)
    au GUIEnter * simalt ~x
else
    " au GUIEnter * simalt ~x
    set tags       +=/usr/local/share/tags/tags
endif

if(g:isWin)
    let &termencoding=&encoding
    set fileencodings=utf8,cp936,ucs-bom,latin1
else
    set encoding=utf8
    set fileencodings=utf8,gb2312,gb18030,ucs-bom,latin1
endif

set viminfo='10,\"100,:20,%,n~/.viminfo

function! BufReadPostFunc()
    if line("'\"") > 0 && line("'\"") <= line("$")
        exe("norm '\"")
    else
        exe "norm $"
    endif
endfunction
autocmd BufReadPost * call BufReadPostFunc()

set dictionary += "/usr/share/vim/dic/all"
set dictionary += "/usr/share/vim/dic/latex"
set dictionary += "/usr/share/vim/dic/misc"
set dictionary += "/usr/share/vim/dic/phrase"
set dictionary += "/usr/share/vim/dic/place"

" set runtimepath^=~/.vim/bundle/ctrlp.vim

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
if (has("cscope") && !has( "win32" ) && !has( "win64" ))
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


" set showbreak=->
" execute pathogen#infect()
" set listchars=tab:>.,trail:.,extends:#,nbsp:. 
" set list
" set listchars=tab:>-,trail:-

autocmd BufRead,BufNewFile  *.h  set filetype=cpp
let g:C_SourceCodeExtensions  = 'h c cc cp cxx cpp CPP c++ C i ii'

let g:timestamp_modelines = 20
let g:timestamp_rep       = '%m/%d/%Y %H:%M:%S'
let g:timestamp_regexp    = '\v\C%(<Last %([cC]hanged?|[Mm]odified):\s+)@<=.*$'

" {{{
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"}}}


"{{{matlab
"source $VIMRUNTIME/macros/matchit.vim
filetype indent on
autocmd BufEnter *.m compiler mlint
" autocmd BufEnter *.m colorscheme desert
"}}}


"{{{AutoPairs
let g:AutoPairsFlyMode = 0
"}}}

let g:fencview_autodetect = 1
let g:fencview_checklines = 10

if has("conceal")
    set conceallevel=0
endif
" set spell

highlight Folded guibg=grey guifg=blue
highlight Folded ctermfg=5 ctermbg=0
" highlight FoldColumn guibg=darkgrey guifg=white

" latex setting {{{
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
let g:Imap_FreezeImap=1

%retab!

" function! BoundForLongLine()
"     :let &colorcolumn=join(range(101,999), ",")
"     " :hi ColorColumn ctermbg=red guibg=red 
"     :hi ColorColumn ctermbg=black guibg=black 
" endfunction
"
" autocmd BufEnter *.m   :call BoundForLongLine()
" autocmd BufEnter *.c   :call BoundForLongLine()
" autocmd BufEnter *.h   :call BoundForLongLine()
" autocmd BufEnter *.sh  :call BoundForLongLine()
" autocmd BufEnter *.cpp :call BoundForLongLine()
" autocmd BufEnter *.hpp :call BoundForLongLine()


if winwidth(0) > 200
    let Tlist_Auto_Highlight_Tag   =1
    let Tlist_Auto_Open            =1
    let Tlist_Auto_Update          =1
    let Tlist_Display_Tag_Scope    =1
    let Tlist_Exit_OnlyWindow      =1
    let Tlist_Enable_Dold_Column   =1
    let Tlist_File_Fold_Auto_Close =1
    let Tlist_Show_One_File        =1
    let Tlist_Use_Right_Window     =1
    let Tlist_Use_SingleClick      =1
endif

" nnoremap <silent> <F8> :TlistToggle<CR>

" filetype plugin on  
" autocmd FileType python set omnifunc=pythoncomplete#Complete  
" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS  
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags  
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS  
" autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags  
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP  
" autocmd FileType c set omnifunc=ccomplete#Complete  

let g:pydiction_location = $HOME."/Dropbox/configure/.vim/bundle/pydiction/complete-dict"

" nmap <F9> :SCCompile<cr> 
" nmap <F10> :SCCompileRun<cr> 
"
" Note that the two lines here should not have any trailing space. If your file 
" type is supported, then press F9 to compile your source file, and press F10 to 
" compile and run your source file. If there is a compilation error, and the 
" |quickfix| feature is enabled, then you could use |:cope| command to see the 
" error list. You may also use ":SCChooseCompiler" command to choose a compiler 
" if you have more than one kind of compiler available on you system. 
" ":SCViewResult" will show you the last run result.
"

" rainbow for parentheses pairs
let g:rainbow_active = 1
let g:rainbow_conf = {
            \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
            \   'operators': '_,_',
            \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \   'separately': {
            \       '*': {},
            \       'tex': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
            \       },
            \       'lisp': {
            \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
            \       },
            \       'vim': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
            \       },
            \       'html': {
            \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
            \       },
            \       'css': 0,
            \   }
            \}

" automatically reload configuration when editing it.
augroup MyVimConfiguration
    autocmd!
    autocmd BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

function! IsWorkHost()
    return hostname() == "vlsj-anhong"
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
    set t_kd        =OA
    set t_ku        =OB
    set t_kr        =OC
    set t_kl        =OD
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
    set t_kd        =OA
    set t_ku        =OB
    set t_kr        =OC
    set t_kl        =OD

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

" use return key to highlight pattern under the cursor currently
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

" cctree
let g:CCTreeCscopeDb = "./.cscope_db/cscope.out"
let g:CCTreeRecursiveDepth = 5
let g:CCTreeMinVisibleDepth = 5
let g:CCTreeOrientation = "above"
let g:CCTreeWindowVertical = 0

" for fugitive Gdiff
" set diffopt+=vertical
if !exists(":Gdiffoff")
    command Gdiffoff diffoff | q | Gedit
endif

" no idea why gvim on windows get wrong font
if g:isWin
    let g:airline_theme = 'light'
    let g:airline_powerline_fonts = 0
else
    let g:airline_theme = 'light'
    let g:airline_powerline_fonts = 1
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

" config for leaderF
" still uses ctrlp shortkey
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_FollowLinks = 1
let g:Lf_PreviewInPopup = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_CommandMap = {'<C-J>': ['<C-N>'], '<C-K>': ['<C-P>']}
" let g:Lf_DefaultMode = 'NameOnly'
if !empty($P_HOME)
    " let g:Lf_WorkingDirectory = $P_HOME
    let g:Lf_RootMarkers = ['.P4Config', '.P4ignore']
    let g:Lf_WorkingDirectoryMode = 'a'
endif

" cmake support for LeaderF
" find the configured source dir: https://stackoverflow.com/questions/27188786/find-source-directory-from-build-directory-in-cmake
if filereadable("CMakeCache.txt")
    for line in readfile("CMakeCache.txt")
        let foundDirLine = matchstr(line, '.*_SOURCE_DIR:STATIC=.*')
        let foundDir = matchstr(foundDirLine, '/.*')
        if !empty(foundDir)
            let g:Lf_WorkingDirectory = foundDir
        endif
    endfor
endif

" if has("patch-8.1.0360")
"     set diffopt+=internal,algorithm:patience
" endif

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

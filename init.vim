" Neovim (0.12+) only config.

if has('win32')
    let g:python3_host_prog = 'C:\Users\anhong\scoop\apps\python\current\python.exe'
endif

" ================
" vim-plug setup
" ================

" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

call plug#begin(stdpath('data').'/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension', 'tag': 'v1.25'}
Plug 'dstein64/vim-startuptime'
Plug 'godlygeek/tabular'
Plug 'bogado/file-line'
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
Plug 'liuchengxu/vim-which-key'
Plug 'chrisbra/csv.vim'
Plug 'github/copilot.vim'
Plug 'etorth/dracula-vim'
Plug 'mvanderkamp/vim-pudb-and-jam'

call plug#end()

" ================
" options
" ================

set number
set cindent
set expandtab
set lazyredraw
set noswapfile
set nowritebackup
set cursorline
set cursorcolumn

set fileformat    =unix
set shiftwidth    =4
set showtabline   =0
set mouse         =
set selectmode    =key
set scrolloff     =9999
set sidescrolloff =9999
set spelllang    +=cjk

if has('win32')
    set tabstop=4
endif

let &undodir = expand('~/.vimundo')
if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
endif
set undofile

" builtin insert-mode autocompletion, LSP results are added in LspAttach below
set autocomplete
set autocompletedelay =200
set completeopt       =menuone,noselect,popup

if !empty($P_HOME)
    if $UTH_ARCH == "Z4"
        let &makeprg="gmake -j 32 debug-install SYSTRG=64bit ETX=9"
    elseif $UTH_ARCH == "Z3"
        let &makeprg="gmake -j 32 debug-install SYSTRG=64bit ETX=8"
    else
        let &makeprg="gmake -j 32 debug-install SYSTRG=64bit"
    endif
endif

" ================
" mappings
" ================

nnoremap <leader>r  :.-1r!
nnoremap j          gj
nnoremap k          gk
xnoremap j          gj
xnoremap k          gk
noremap  H          ^
noremap  L          $

noremap  <F1>       <NOP>
noremap  <UP>       <NOP>
noremap  <DOWN>     <NOP>
noremap  <LEFT>     <NOP>
noremap  <RIGHT>    <NOP>
inoremap <F1>       <NOP>
inoremap <UP>       <NOP>
inoremap <DOWN>     <NOP>
inoremap <LEFT>     <NOP>
inoremap <RIGHT>    <NOP>

nnoremap gf         :sp <cfile><CR>
nnoremap <C-J>      :bn<CR>
nnoremap <C-K>      :bp<CR>

" ================
" autocmds
" ================

augroup init_filetypes
    autocmd!
    autocmd BufRead,BufNewFile *.fl         set filetype=cpp
    autocmd BufRead,BufNewFile *.qel,*.xel  set filetype=tcl

    autocmd BufRead,BufNewFile *.c,*.h,*.hpp,*.sh setlocal foldmethod=indent
    autocmd FileType c,cpp,sh,bash  setlocal nowrap
    autocmd FileType text,tex,plaintex setlocal spell

    " syntax files reset sync settings when loaded, so apply it per buffer
    autocmd Syntax * syntax sync fromstart
augroup END

" ================
" plugin settings
" ================

" set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1

let g:alternateExtensions_C = "h,hpp,H,HPP"
let g:alternateExtensions_h = "c,cpp,cxx,cc,CC,C,CPP,CXX"

for s:node in ['/grid/common/pkgs/node/v24.4/bin/node', expand('~/node-latest-linux-x64/bin/node')]
    if executable(s:node)
        let g:copilot_node_command = s:node
        break
    endif
endfor
unlet! s:node

imap <silent><script><expr> <C-L> copilot#Accept("")
let g:copilot_no_tab_map = v:true

" ================
" colorscheme
" ================

augroup init_colors
    autocmd!
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
augroup END

set termguicolors
set background=dark
let g:dracula_high_contrast_diff = 1
colorscheme dracula

" highlight all trailing whitespaces
augroup init_trailing_whitespace
    autocmd!
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
augroup END
match ExtraWhitespace /\s\+$/

" remove all trailing whitespaces
nnoremap <silent> <leader>ds <Cmd>keeppatterns %s/\s\+$//e<CR>

" ================
" functions and commands
" ================

function! Tailf()
    if !empty(expand('%:p')) && !&modified
        edit
    endif
    normal! G0
    redraw
endfunction
nnoremap <silent> T <Cmd>call Tailf()<CR>

function! IgnoreSpaceDiff()
    if &diff
        set diffopt+=iwhite
    else
        echohl ErrorMsg | echo "Not in diff mode!" | echohl None
    endif
endfunction
command! IgnoreSpaceDiff :call IgnoreSpaceDiff()

function! SwitchDiffOptFunc()
    let l:algorithms = ['myers', 'minimal', 'patience', 'histogram']
    let l:current_algo = 'myers'

    for algo in l:algorithms
        if &diffopt =~ 'algorithm:' . algo
            let l:current_algo = algo
            break
        endif
    endfor

    let l:next_algo = l:algorithms[(index(l:algorithms, l:current_algo) + 1) % len(l:algorithms)]

    execute 'set diffopt-=algorithm:' . l:current_algo
    execute 'set diffopt+=algorithm:' . l:next_algo

    echo 'Diff Algorithm: ' . l:current_algo . ' -> ' . l:next_algo
endfunction
command! SwitchDiffOpt :call SwitchDiffOptFunc()

function! Tabspace2()
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
endfunction
command! Tabspace2 :call Tabspace2()

function! DiffWithSavedFunc()
    if empty(expand('%'))
        echohl ErrorMsg | echo "Buffer is not loaded from saved file" | echohl None
        return
    endif

    let l:filetype = &ft
    diffthis
    vnew | read # | normal! 1Gdd
    diffthis
    execute "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . l:filetype
endfunction
command! DiffWithSaved call DiffWithSavedFunc()

" highlight current line *permanently*, uses :2match to not clash with ExtraWhitespace
let g:permanent_highlight_line = 0
function! PermanentHighlightingFunc()
    if g:permanent_highlight_line == line('.')
        2match none
        let g:permanent_highlight_line = 0
    else
        execute '2match Search /\%' . line('.') . 'l/'
        let g:permanent_highlight_line = line('.')
    endif
endfunction
xnoremap <silent> <CR> <ESC>:call PermanentHighlightingFunc()<CR>

" use space key to highlight word under the cursor
let g:highlighting_under_cursor = 0
function! HighlightingUnderCursor()
    let l:pattern = '\<' . expand('<cword>') . '\>'
    if g:highlighting_under_cursor == 1 && @/ ==# l:pattern
        let g:highlighting_under_cursor = 0
        return ":silent nohlsearch\<CR>"
    endif

    let @/ = l:pattern
    let g:highlighting_under_cursor = 1
    return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> <SPACE> HighlightingUnderCursor()

" ================
" lua plugins and LSP
" ================

lua << EOF
require('nvim-autopairs').setup({})

-- server configs come from nvim-lspconfig (lsp/clice.lua, lsp/clangd.lua)
-- clice needs a compile_commands.json, see https://github.com/clice-io/clice
if vim.fn.executable('clice') == 1 then
    vim.lsp.enable('clice')
else
    for _, clangd in ipairs({ '/grid/common/pkgs/llvm/ps2027/bin/clangd', 'clangd' }) do
        if vim.fn.executable(clangd) == 1 then
            vim.lsp.config('clangd', {
                cmd = { clangd, '--background-index', '--clang-tidy', '--completion-style=detailed', '--header-insertion=never', '--header-insertion-decorators=0' },
            })
            vim.lsp.enable('clangd')
            break
        end
    end
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('init_lsp', {}),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client or not client:supports_method('textDocument/completion') then
            return
        end

        -- handles snippets and additionalTextEdits of accepted items
        vim.lsp.completion.enable(true, client.id, ev.buf)

        -- let 'autocomplete' query the LSP omnifunc first
        local cpt = vim.bo[ev.buf].complete
        if not vim.tbl_contains(vim.split(cpt, ','), 'o') then
            vim.bo[ev.buf].complete = 'o,' .. cpt
        end
    end,
})
EOF

" ================
" LeaderF, menu is implemented by vim-which-key
" ================

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

" find the configured source dir: https://stackoverflow.com/questions/27188786/find-source-directory-from-build-directory-in-cmake
function! SearchCmakeSourceDir() abort
    if filereadable("CMakeCache.txt")
        for line in readfile("CMakeCache.txt")
            let foundDir = matchstr(matchstr(line, '.*_SOURCE_DIR:STATIC=.*'), '/.*')
            if !empty(foundDir)
                execute 'Leaderf file ' . foundDir
                return
            endif
        endfor
    endif
    Leaderf file
endfunction

let g:which_key_centered = 1
let g:which_key_vertical = 1
let g:which_key_map = {}
let g:which_key_map['LeaderF'] = {
            \ 'name': '+LeaderF',
            \ 'b' : ['<cmd>LeaderfBuffer\<cr>',               'current-buffers'],
            \ 'f' : ['<cmd>Leaderf file\<cr>',                'current-directory'],
            \ 'r' : ['<cmd>Leaderf --regexMode rg\<cr>',      'regex-search dir'],
            \ 'g' : ['<cmd>call SearchGitRepo()\<cr>',        'git-repository'],
            \ 'p' : ['<cmd>call SearchP4Client()\<cr>',       'perforce-client'],
            \ 'c' : ['<cmd>call SearchCmakeSourceDir()\<cr>', 'cmake-source'],
            \ }
nnoremap <C-P> <cmd>WhichKey! g:which_key_map['LeaderF']<cr>

set noeb
set novb
set vb t_vb=

color desertEx

" set guifont=FreeMono\ 14

set guioptions=
set mouse=

set nospell

if (g:isWin)
    winpos 0 0
    set lines=80 columns=120
    "set guifont=Consolas:h13:w8:cANSI
    " set guifont=Courier\ New:h13:w8:cANSI
    " set guifont=Monaco\ for\ Powerline:h13:w8:cANSI
    " set guifont=Monaco_for_Powerline:h13:w8:cANSI
    " set guifont=Monaco\ for\ Powerline:h13:w8
    " set guifont=Monaco\ for\ Powerline
    " set guifont=Courier\ New:h10:w6:cANSI
    "se guifont=monaco:h13:w8:cANSI
    "se guifont=monaco:h19:w12:cANSI
    "se gfw=Yahei\ Mono:h13:w8:cGB2312
    "se linespace=1
    "se antialias
    "se guifontwide=Yahei\ Mono:h13:w8:cGB2312  
    "se guifont=monaco:h13:w8:cANSI
    "se guifontwide=Yahei\ Mono:h13:w8:cGB2312  
    "se guifont=Yahei\ Mono:h16:w10:cGB2312 "gre_writing
    "se gfw=YaHei\ Consolas\ Hybrid:h13:w8
    "
    "
    set spell
else
    " set guifont=Courier\ 10\ Pitch\ 13
    set guifont=DejaVu\ Sans\ Mono\ 16
endif

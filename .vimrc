"===============================================================================
"VIM Configuration File
"Description:  I do mostly C++ development and this .vimrc file refelcts that. 
"Author: Andrew Pierson
"==============================================================================



"------------------------------------------------------------------------------
"Settings
"
"------------------------------------------------------------------------------ 
"This is a default setting that I grabbed from what was default in the obb
"lab.
set printoptions=paper:letter,syntax:n

"Trun on that syntax highlighting
syntax on

"turn on doxygen syntax hilighting. Works for C, C++, C#, and IDL files.
let g:load_doxygen_syntax=1


"At least let yourself know what mode you are in
set showmode

"Change those peskey tabs to spaces
"If you ever want a real tab character use Ctrl-V<tab> key sequence
set expandtab

"Of course many applications us 4 spaces for a tab
set tabstop=4

"Indent by 4 spaces when using >>, <<, ==, ect.
set shiftwidth=4

"highlight all matching phrases
set hlsearch

"show partial matches for a search phrase
set incsearch

"use the indent of the previous line for a newly created line
set autoindent

"Always display the current cursor position in the lower right corner of the Vim
"window.
set ruler

"remember more commands and search history
set history=1000

"use many levels of undo
set undolevels=1000

"dectect the type of file and trun the plugin on
filetype plugin on

"trun file type indent on
filetype indent on

"can't forget those line numbers!
set number

"change the mapleader from \ to ,
let mapleader=";"

"If you use upper and lowercase in your expression it will do a case
"sensative search.
"/copyright     case insensitive
"/Copyright     case sensitive
"/copyright\C   case sensitive
"/Copyright\c   case insensitive
"Both ignorecase and smartcase need to be set in order for smartcase to
"workThe 'smartcase' option only applies to search patterns that you type; it
"does not apply to * or # or gd. If you press * to search for a word, you can
"make 'smartcase' apply by pressing / then up arrow then Enter (to repeat the
"search from history).
set ignorecase
set smartcase 

"Turn on doxygen syntax hilighting.
set syntax=cpp.doxygen 





"------------------------------------------------------------------------------
"Spell checking, auto-completion, thesaurus lookup etc..
"------------------------------------------------------------------------------ 
"
"Word / Pattern Completion     Ctrl-x Ctrl-n or CTRL-x CTRL-p
"Line Completion               Ctrl-x Ctrl-l
"File Name Completion          Ctrl-x Ctrl-f
"*Dictionary Word Completion   Ctrl-x Ctrl-k
"*Thesaurus                    Ctrl x + Ctrl t

"This is to enable using a thesaurus.
" To use press    Ctrl x + Ctrl t
" The thesaurus file that I use can be downloaded from:
" http://www.gutenberg.org/dirs/etext02/mthes10.zip
set thesaurus+=~/mthesaur.txt

"seting up a dictionary to use.
"With this we can use Ctrl x + Ctrl K  to get into the dictionary
"then we can cycle through our options with Ctrl n and Ctrl p
set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words

"While in insert mode CTRL-N and CTRL-P will cycle through a predetermined
"set of completion sources. By default, dictionary completion is not a part 
"of this set. This set is defined by the 'complete' option. Therefore, we 
"must add dictionary to this as shown below:
"This is from: http://vim.wikia.com/wiki/VimTip91
set complete-=k complete+=k
"Now, while in insert mode we can type the following to complete a word:
"Ctrl n   Ctrl n




"------------------------------------------------------------------------------
"Key Mappings
"------------------------------------------------------------------------------ 

"This is for debugging.
map cn <esc>:cn<cr>
"Goto the previous error/warning in the source code.
map cp <esc>:cp<cr>

nn <F7> :setlocal spell! spell?<CR>

map <leader>n :noh<CR>


"Map <F12> to open a new tab with the .vimrc file
"Used for fast access.
map <F12> :tabnew ~/.vimrc<CR>


"Temporarily switch to “paste mode”. Paste while in insert mode.
set pastetoggle=<F2>


"Hilights anything over 80 characters long. Mapped to some keys to turn it bla
"http://vim.wikia.com/wiki/Highlight_long_lines
nnoremap <silent> <F8>
      \ :if exists('w:long_line_match') <Bar>
      \   silent! call matchdelete(w:long_line_match) <Bar>
      \   unlet w:long_line_match <Bar>
     \ elseif &textwidth > 0 <Bar>
      \   let w:long_line_match = matchadd('ErrorMsg', '\%>'.&tw.'v.\+', -1) <Bar>
      \ else <Bar>
      \   let w:long_line_match = matchadd('ErrorMsg', '\%>80v.\+', -1) <Bar>
      \ endif<CR>


"Highligts anything over 80 characters long.
"highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
"match OverLength /\%>80v.\+/


"visually select block of text to comment.(C/C++ style comments)
"I use mostly C style comments so these are my primary.
vmap c :s/^/\/\//<CR>:noh<CR>

"Uncomment visually selected text, n stands for no as in no comment.
vmap u :g/\s*\/\//s/\/\///<CR>:noh<CR>

"visually select block of text to comment.(python style comments)
"The leader key is added to the normal comment uncomment commands for python
"syle comments.
vmap <Leader>c :s/^/#/<CR>:noh<CR>

"Uncomment visually selected text, n stands for no as in no comment.
vmap <Leader>u :g/\s*#/s/#//<CR>:noh<CR>

"This will start highlighting as to start warning you when the text is starting to get
"close to your 80 character limit.
"au BufWinEnter * if &textwidth > 3
"            \ | let w:m1=matchadd('MatchParen', printf('\%%<%dv.\%%>%dv', &textwidth+1, &textwidth-8), -1)
"            \ | let w:m2=matchadd('ErrorMsg', printf('\%%>%dv.\+', &textwidth), -1)
"            \ | endif


"Mapping of keys to output current time.
":map <F2> :echo 'Current time is ' . strftime('%c')<CR>

"Easy way to change colorscheme key mapings.
map <silent> <F9> :call ChangeColor(1)<CR>
map <silent> <S-F9> :call ChangeColor(-1)<CR>


"Map some keys to the functions that insert comment blocks
"This idea is from Ryan Housh his website is: lostrobot.org
nmap <F3> :r~/.vim/cpp/commentHeader.cpp<CR>
nmap <F4> :r~/.vim/cpp/commentFunction.cpp<CR>
nmap <F5> :r~/.vim/cpp/commentBrief.cpp<CR>
"An insert then backspace is added so a newline is not produced.
nmap <F6> :r~/.vim/cpp/commentNote.cpp<CR>i<BS><esc>wcw



"-------------------------------------------------------------------------------
"Functions
"-------------------------------------------------------------------------------



"---------------Changing Color Schemes------------------------------------------

"Idea for color changing from:
"http://vim.wikia.com/wiki/Switch_color_schemes

"Default colors are all the colors availible.
let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
let s:mycolors = map(paths, 'fnamemodify(v:val, ":t:r")')

"Default colors are the ones defined in the following list.
"let s:mycolors = ['slate', 'torte', 'darkblue', 'delek', 'murphy', 'elflord', 'pablo', 'koehler']  

" Set list of color scheme names that we will use.
function! s:SetColors(args)
    if len(a:args) == 0
        echo 'Current color scheme names:'
        let i = 0
        while i < len(s:mycolors)
            echo '  '.join(map(s:mycolors[i : i+4], 'printf("%-14s", v:val)'))
            let i += 5
        endwhile
    elseif a:args == 'my'
        let s:mycolors = ['default', 'darkblue', 'murphy', 'elflord',] 
    elseif a:args == 'all'
        let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
        let s:mycolors = map(paths, 'fnamemodify(v:val, ":t:r")')
        echo 'List of colors set from all installed color schemes'
    else
        let s:mycolors = split(a:args)
        echo 'List of colors set from argument (space-separated names)'
    endif
endfunction

command! -nargs=* SetColors call s:SetColors('<args>')


let s:i = 0
function! ChangeColor(direction)
    let direction = a:direction
    let s:i += direction
    if !(0 <= s:i && s:i < len(s:mycolors))
        let s:i = (direction>0 ? 0 : len(s:mycolors)-1)
    endif
    execute 'colorscheme '.s:mycolors[s:i]
    redraw
    echo g:colors_name
endfunction
















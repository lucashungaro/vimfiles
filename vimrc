set nocompatible                  " Must come first because it changes other options.

" Manage the runtime path with  Pathogen.
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

set encoding=utf-8

let mapleader=","
nnoremap ; :

ca W w

runtime macros/matchit.vim        " Load matchit.vim plugin.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=longest,list         " Complete files like a shell.

set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,*.jpg,*.jpeg,*.png,*.gif,vendor/**,db/sphinx,log/**,tmp/**,public/uploads,coverage/**

" Better Completion
set completeopt=longest,menuone,preview

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show absolute line numbers (cf. relativenumber).
set ruler                         " Show cursor position.
set cursorline                    " Highlight current line
set laststatus=2                  " Always show a status line.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set shiftwidth=2                  "
set tabstop=2                     " Tabs and spaces.
set expandtab                     "

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " No backups.
set nowritebackup                 " No backups.
set noswapfile                    " No swap files; more hassle than they're worth.

set tildeop                       " Make tilde command behave like an operator.
set shortmess=atI                 " Avoid unnecessary hit-enter prompts.

set noequalalways                 " Resize windows as little as possible.

set autoread                      " Automatically re-read files changed outside Vim.

set t_Co=256 " 256 colors
set background=dark
colorscheme badwolf

let g:sql_type_default = "mysql"
let g:CommandTMaxFiles = 5000

" Very magic regexes.
nnoremap / /\v
vnoremap / /\v

" OS X-like space bar to scroll.
nnoremap <Space> <C-F>

" <Leader><space> turns off search highlighting.
nnoremap <Leader><space> :noh<CR>

" Kill trailing White Space
nnoremap <Leader>kws :%s/\s\+$//<CR>

" System clipboard interaction
" From
" https://github.com/henrik/dotfiles/blob/master/vim/config/mappings.vim
noremap <leader>y "*y
noremap <leader>p :set paste<CR>"*p<CR>:set nopaste<CR>
noremap <leader>P :set paste<CR>"*P<CR>:set nopaste<CR>

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Formatting, TextMate-style
nnoremap Q gqip
vnoremap Q gq

" Select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Directory of current file.
cnoremap %% <C-R>=expand("%:h")."/"<CR>

" Map § to # for typing convenience
set iminsert=1
set imsearch=-1
noremap  § #
noremap! § #
lnoremap § #

" Make Y consistent with D and C (instead of yy)
noremap Y y$

" Visually select the text that was most recently edited/pasted.
nmap gV `[v`]

" Make * and # work with visual selection.
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" indent, reselect
:vmap < <gv
:vmap > >gv

" Use cursor keys to navigate buffers.
map  <Right> :bnext<CR>
map  <Left>  :bprev<CR>
imap <Right> <ESC>:bnext<CR>
imap <Left>  <ESC>:bprev<CR>
map  <Del>   :bd<CR>

" Show tabs and trailing whitespace visually
" http://github.com/ciaranm/dotfiles-ciaranm/blob/master/vimrc
"
" See also here for a different solution:
" http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
if (&termencoding == "utf-8") || has("gui_running")
  if v:version >= 700
    if has("gui_running")
      set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
    else
      " xterm + terminus hates these
      set list listchars=tab:»·,trail:·,extends:>,nbsp:_
    endif
  else
    set list listchars=tab:»·,trail:·,extends:…
  endif
else
  if v:version >= 700
    set list listchars=tab:>-,trail:.,extends:>,nbsp:_
  else
    set list listchars=tab:>-,trail:.,extends:>
  endif
endif

"
" Plugins
"
" BufExplorer configuration
nmap <script> <silent> <unique> <Leader><Leader> :BufExplorer<CR>
let g:bufExplorerShowRelativePath=1
"let g:bufExplorerShowUnlisted=1

" ack.vim
nmap <silent> <unique> <Leader>a :Ack
nmap <silent> <unique> <Leader>as :AckFromSearch
nmap <silent> <unique> <Leader>af :AckFile

" Tabularize
"if exists(':Tabularize')
"           ^^^^^^^^^^^^ for some reason Tabularize hasn't loaded when Vim gets here
nmap <Leader>t= :Tabularize /=<CR>
vmap <Leader>t= :Tabularize /=<CR>
" key => value
nmap <Leader>t> :Tabularize /=><CR>
vmap <Leader>t> :Tabularize /=><CR>
" key: value
nmap <Leader>t: :Tabularize /:\zs<CR>
vmap <Leader>t: :Tabularize /:\zs<CR>
" Ruby symbols
nmap <Leader>ts :Tabularize /:/l1c0l0<CR>
vmap <Leader>ts :Tabularize /:/l1c0l0<CR>

" a few useful shortcuts - taken from https://github.com/lsdr/vim-folder/blob/master/_vimrc :)
command! Rehash source ~/.vimrc
command! Helptags helptags ~/.vim/doc

" all the code below from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPS TO JUMP TO SPECIFIC COMMAND-T TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>ga :CommandTFlush<cr>\|:CommandT app/assets<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT app/presenters<cr>
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gC :CommandTFlush<cr>\|:CommandT config<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT spec<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gt :CommandTFlush<cr>\|:CommandTTag<cr>
map <leader>t :CommandTFlush<cr>\|:CommandT<cr>
map <leader>T :CommandTFlush<cr>\|:CommandT %%<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>l :PromoteToLet<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!script/features " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunTestFileNoRails()
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
       call SetTestFile()
       :w
       exec ":!rspec --color " . t:grb_test_file
    end
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number . " -b")
endfunction

map <leader>s :call RunTestFile()<cr>
map <leader>S :call RunNearestTest()<cr>
map <leader>b :call RunTestFileNoRails()<cr>
map <leader>a :call RunTests('')<cr>
" map <leader>c :w\|:!script/features<cr>
" map <leader>w :w\|:!script/features --profile wip<cr>


" All functions bellow from https://github.com/vim-scripts/Specky
"
" When in ruby code or an rspec BDD file, try and search recursively through
" the filesystem (within the current working directory) to find the
" respectively matching file.  (code to spec, spec to code.)
"
" This operates under the assumption that you've used chdir() to put vim into
" the top level directory of your project.

function! SpecSwitcher()
  " If we aren't in a ruby or rspec file then we probably don't care
  " too much about this function.
  if &ft != 'ruby' && &ft != 'rspec'
    call s:err( "Not currently in ruby or rspec mode." )
    return
  endif

  " Ensure that we can always search recursively for files to open.
  let l:orig_path = &path
  set path=**

  " Get the current buffer name, and determine if it is a spec file.
  "
  " /tmp/something/whatever/rubycode.rb ---> rubycode.rb
  " A requisite of the specfiles is that they match to the class/code file,
  " this emulates the eigenclass stuff, but doesn't require the same
  " directory structures.
  "
  " rubycode.rb ---> rubycode_spec.rb
  let l:filename     = matchstr( bufname('%'), '[0-9A-Za-z_.-]*$' )
  let l:is_spec_file = match( l:filename, '_spec.rb$' ) == -1 ? 0 : 1

  if l:is_spec_file
    let l:other_file = substitute( l:filename, '_spec\.rb$', '\.rb', '' )
  else
    let l:other_file = substitute( l:filename, '\.rb$', '_spec\.rb', '' )
  endif

  let l:bufnum = bufnr( l:other_file )
  if l:bufnum == -1
    " The file isn't currently open, so let's search for it.
    execute 'find ' . l:other_file
  else
    " We've already got an open buffer with this file, just go to it.
    execute 'buffer' . l:bufnum
  endif

  "execute 'set path=' . l:orig_path
endfunction

nnoremap <leader>. :call SpecSwitcher()<cr>

" Wrap the word under the cursor in quotes.  If in ruby mode,
" cycle between quoting styles and symbols.
"
" variable -> "variable" -> 'variable' -> :variable
"
function! QuoteSwitcher()
  let l:type = strpart( expand("<cWORD>"), 0, 1 )
  let l:word = expand("<cword>")

  if l:type == '"'
    " Double quote to single
    execute ":normal viWc'" . l:word . "'"

  elseif l:type == "'"
    if &ft == 'ruby' || &ft == 'rspec'
      " Single quote to symbol
      execute ':normal viWc:' . l:word
    else
      " Single quote to double
      execute ':normal viWc"' . l:word . '"'
    end

  else
    " Whatever to double quote
    execute ':normal viWc"' . l:word . '"'
  endif

  " Move the cursor back into the cl:word
  call cursor( 0, getpos('.')[2] - 1 )
endfunction

nnoremap <leader>qs :call QuoteSwitcher()<cr>

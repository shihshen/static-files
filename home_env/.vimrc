" Environment {

    " Basics {
        set nocompatible        " Must be first line
    " }

" }

" General {

    set background=dark         " Assume a dark background
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set noswapfile              " Disable swap file.
    set nobackup                " Disable backup file.
    scriptencoding utf-8

" }


" Formatting {

    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=2                " Use indents of 2 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=2                   " An indentation every 2 columns
    set softtabstop=2               " Let backspace delete indent
    "set mouse=v                     " Enable mouse for copying. However, mouse may not be supported.
    set ignorecase                  " Smart search
    set smartcase

" }

" Key (re)Mappings {

    " The default leader is '\', but many people prefer ',' as it's in a standard
    " location. To override this behavior and set it back to '\' (or any other
    " character) add the following let g:leader='\'
    if !exists('g:leader')
        let mapleader = ','
    else
        let mapleader=g:leader
    endif

    " Easier creating tabs
    map <leader>t :tabnew<CR>

    " Easier moving in windows
    " The lines conflict with the default digraph mapping of <C-K>
    " If you prefer that functionality, add let g:no_easyWindows = 1
    if !exists('g:no_easyWindows')
        map <C-J> <C-W>j
        map <C-K> <C-W>k
        map <C-L> <C-W>l
        map <C-H> <C-W>h
        if has('nvim')
          " Hack to get C-h working in NeoVim
          nmap <BS> <C-W>h
        endif
    endif

    " Easier moving in tabs
    " The following two lines conflict with moving to top and
    " bottom of the screen
    " If you prefer that functionality, add the following line
    "   let g:no_fastTabs = 1
    if !exists('g:no_fastTabs')
        map <S-E> gT
        map <S-R> gt
    endif

    " Continuous indentation
    vnoremap < <gv
    vnoremap > >gv

    " Map <leader>fr to find and replace all words under the cursor in this file with 's'
    nmap <leader>fr :%s/\<<C-r><C-w>\>/s/gc

" }

" Plugins {
    " Get vim-plug first at https://github.com/junegunn/vim-plug
    call plug#begin('~/.vim/plugged')

    " list only the plugin groups you will use
    if !exists('g:bundle_groups')
        let g:bundle_groups=['general', 'programming']
    endif

    " General
        if count(g:bundle_groups, 'general')
            Plug 'altercation/vim-colors-solarized'
            Plug 'bling/vim-airline'
            Plug 'scrooloose/nerdtree'
            Plug 'jistr/vim-nerdtree-tabs'
                map <leader>n :NERDTreeToggle<CR>:NERDTreeMirror<CR>
                map <leader>e :NERDTreeFind<CR>
                nmap <leader>nt :NERDTreeFind<CR>
                let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
                let NERDTreeChDirMode=0
                let NERDTreeMouseMode=2
                let NERDTreeShowHidden=1
                let NERDTreeKeepTreeInNewTab=1
                let g:nerdtree_tabs_open_on_gui_startup=0
                let g:NERDTreeDirArrows=0
                let g:NERDTreeDirArrowExpandable = ">"
                let g:NERDTreeDirArrowCollapsible = "<"
        endif

    " General Programming
        if count(g:bundle_groups, 'programming')
            Plug 'ctrlpvim/ctrlp.vim'
            if executable('rg')
              let g:ctrlp_user_command = 'rg %s --files --no-ignore --color=never --glob ""'
            endif
            let g:ctrlp_switch_buffer = 'ET'
            let g:ctrlp_prompt_mappings = { 
                  \ 'AcceptSelection("e")': ['<c-t>', '<2-LeftMouse>'],
                  \ 'AcceptSelection("t")': ['<cr>']
                  \ }
            Plug 'mhinz/vim-grepper'
                if executable('ag')
                    nnoremap <SPACE>/ :GrepperAg 
                else
                    nnoremap <SPACE>/ :Grepper 
                endif
            Plug 'scrooloose/syntastic'
                au BufRead,BufNewFile *.json set filetype=json
                let g:syntastic_javascript_checkers = ['flow']
                let g:syntastic_mode_map = {
                  \ "mode": "active",
                  \ "passive_filetypes": ["python"]
                  \}
            " Autocomplete: tabnine (high memory consumption), deoplete (unstable), youcompleteme (complicated installation) have their own issues for now.
            Plug 'ervandew/supertab'
            Plug 'will133/vim-dirdiff'
        endif

    " Misc
        if count(g:bundle_groups, 'misc')
            " Auto format/indent
            Plug 'google/vim-maktaba'
            Plug 'google/vim-codefmt'
            Plug 'google/vim-glaive'
            augroup autoformat_settings " Use :NoAutoFormatBuffer to disable current buffer formatting.
                autocmd FileType bzl AutoFormatBuffer buildifier
                autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
                autocmd FileType dart AutoFormatBuffer dartfmt
                autocmd FileType go AutoFormatBuffer gofmt
                autocmd FileType gn AutoFormatBuffer gn
                autocmd FileType javascript,html,css,sass,scss,less,json AutoFormatBuffer js-beautify
                autocmd FileType java AutoFormatBuffer google-java-format
                autocmd VimEnter * Glaive codefmt google_java_executable="java -jar ~/google-java-format-1.7-all-deps.jar"
                autocmd FileType python AutoFormatBuffer yapf
                " Alternative: autocmd FileType python AutoFormatBuffer autopep8
            augroup END
        endif
    
    " Initialize plugin system
    call plug#end()

" }

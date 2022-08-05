{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ 
      vim-airline 
      vim-airline-themes
      surround 
      nvim-treesitter
      
      orgmode
      vim-eunuch 
      vim-nix 
      tagbar
      nerdtree
      haskell-vim

    ];

    withPython3 = true;

    extraConfig = ''
      set number
      syntax enable
      filetype plugin indent on
      set expandtab
      set smarttab
      set shiftwidth=4
      set tabstop=4
      set laststatus=2

      map <C-n> :NERDTreeToggle<CR>
      let NERDTreeShowHidden=1

      let g:instant_markdown_autostart = 0         
      let g:instant_markdown_browser = "qutebrowser"      
      map <C-m-d> :InstantMarkdownPreview<CR>   
      map <C-m-d> :InstantMarkdownStop<CR>      

      let g:airline_theme='powerlineish'

      let g:haskell_enable_quantification = 1   
      let g:haskell_enable_recursivedo = 1      
      let g:haskell_enable_arrowsyntax = 1      
      let g:haskell_enable_pattern_synonyms = 1 
      let g:haskell_enable_typeroles = 1        
      let g:haskell_enable_static_pointers = 1  
      let g:haskell_backpack = 1                
      let g:haskell_indent_if = 3
      let g:haskell_indent_case = 2
      let g:haskell_indent_let = 4
      let g:haskell_indent_where = 6
      let g:haskell_indent_before_where = 2
      let g:haskell_indent_after_bare_where = 2
      let g:haskell_indent_do = 5
      let g:haskell_indent_in = 2
      let g:haskell_indent_guard = 4
      let g:haskell_indent_case_alternative = 1

      let g:cabal_indent_section = 2
    '';

  };
}
/*
      highlight Normal           guifg=#dfdfdf ctermfg=15   guibg=#282c34 ctermbg=none  cterm=none
      highlight LineNr           guifg=#5b6268 ctermfg=8    guibg=#282c34 ctermbg=none  cterm=none
      highlight CursorLineNr     guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
      highlight VertSplit        guifg=#1c1f24 ctermfg=0    guifg=#5b6268 ctermbg=8     cterm=none
      highlight Statement        guifg=#dfdfdf ctermfg=2    guibg=none    ctermbg=none  cterm=none
      highlight Directory        guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=none
      highlight StatusLine       guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
      highlight StatusLineNC     guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
      highlight NERDTreeClosable guifg=#98be65 ctermfg=2
      highlight NERDTreeOpenable guifg=#5b6268 ctermfg=8
      highlight Comment          guifg=#5f7da5 ctermfg=4    guibg=none    ctermbg=none  cterm=italic
      highlight Constant         guifg=#3071db ctermfg=12   guibg=none    ctermbg=none  cterm=none
      highlight Special          guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=none
      highlight Identifier       guifg=#5699af ctermfg=6    guibg=none    ctermbg=none  cterm=none
      highlight PreProc          guifg=#c678dd ctermfg=5    guibg=none    ctermbg=none  cterm=none
      highlight String           guifg=#462a4e ctermfg=12   guibg=none    ctermbg=none  cterm=none
      highlight Number           guifg=#315483 ctermfg=1    guibg=none    ctermbg=none  cterm=none
      highlight Function         guifg=#ff6c6b ctermfg=1    guibg=none    ctermbg=none  cterm=none
      highlight Visual           guifg=#dfdfdf ctermfg=1    guibg=#1c1f24 ctermbg=none  cterm=none
*/

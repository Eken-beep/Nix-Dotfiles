{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ 
      vim-airline 
      surround 
      nvim-treesitter
      orgmode
      vim-eunuch 
      vim-nix 
      haskell-vim 
      tagbar
      coc-rls
      nerdtree
      nord-vim

    ];

    withPython3 = true;

    extraConfig = ''
      set number
    '';

  };
}

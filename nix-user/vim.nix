{ pkgs, config, ... }:

{
  programs.vim = {
    enable = true;

    settings = {
      background = "light";
      history = 1000;
      undofile = true;
    };

    plugins = with pkgs.vimPlugins; [
      ale
      vim-surround
      vim-airline
      tabular

      nerdtree
      vim-nerdtree-syntax-highlight
      nerdcommenter

      haskell-vim
      vim-nix
    ];
  };
}

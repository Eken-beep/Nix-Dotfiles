{ lib, config, pkgs, commands, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      ed  = "nvim";
      ll = "ls -la";
      hmrs = "home-manager switch";
      "..." = "cd ../..";
      pkgdir = "/home/edvin/.config/nixpkgs/";
    };

    shellInit = "neofetch";

    plugins = [
      {
        name = "fasd";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-fasd";
          rev = "38a5b6b6011106092009549e52249c6d6f501fba";
          sha256 = "06v37hqy5yrv5a6ssd1p3cjd9y3hnp19d3ab7dag56fs1qmgyhbs";
        };
      }

      {
        name = "sudope";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-sudope";
          rev = "0";
          sha256 = "0";
        };
      }

      {
        name = "done";
        src = pkgs.fishPlugins.done;
      }

      {
        name = "grc";
        src = pkgs.fishPlugins.grc;
      }
    ]
  };
}

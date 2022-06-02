{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    userName = "Edvin Källström";
    userEmail = "edvin.kallstrom@protonmail.com";
  };
}

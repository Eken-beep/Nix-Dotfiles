{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "edvin";
  home.homeDirectory = "/home/edvin";

  # Home manager version
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Enabling playerctl to control videos and music with the mediakeys
  services.playerctld.enable = true;
  
  # Eww
  programs.eww = {
    enable = true;
    configDir = /home/edvin/.config/eww;
  };

  # Imports of modules
  imports = [
      ./dunst.nix 
      ./git.nix 
      ./kitty.nix 
      ./mpd.nix 
      ./neovim.nix 
      ./picom.nix 
      ./qute.nix 
      ./vim.nix 
      ./zsh.nix
  ];

  # Programs
  home.packages = with pkgs; [
    # Games
    polymc
    steam
    lutris
    amidst
    cubiomes-viewer
    minecraft

    # Gui stuff
    firefox
    chromium

    alacritty

    spotify

    tdesktop
    signal-desktop
    discord

    gimp
    inkscape
    onlyoffice-bin
    gnome-latex

    feh
    cozy
    mpv
    pavucontrol

    qbittorrent

    obs-studio
    arduino

    freetube

    keepassxc
    protonmail-bridge

    # package sets
    # haskellPackages.movie-monad
    python310Packages.adblock

    # Stooooph
    xmobar
    dmenu
    rofi
    dunst
    flameshot
    lxappearance 
    xlockmore
    wine

    pfetch
    neofetch
    ranger
    signal-cli
    appimage-run
    unzip
    wiki-tui
    matrixcli
    zlib
    pkg-config
    
    # gnome things
    gnome.gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.vitals
    gnomeExtensions.forge
    gnomeExtensions.extension-list
    gnomeExtensions.workspace-indicator-2
    # gnomeExtensions.dash-to-dock
    # gnomeExtensions.material-shell
    
  ];
}

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

  # Imports of modules
  imports = [
    ./zsh.nix
    ./kitty.nix
    ./neovim.nix
    ./picom.nix
    ./qute.nix
    ./git.nix
    ./dunst.nix
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

    spotify

    tdesktop
    signal-desktop
    discord

    gimp
    inkscape
    onlyoffice-bin
    gnome-latex
    cozy

    qbittorrent

    obs-studio
    arduino

    freetube

    # Mining
    monero-gui
    xmrig

    # Stooooph
    xmobar
    dmenu
    rofi
    dunst
    flameshot
    lxappearance 

    pfetch
    neofetch
    ranger
    signal-cli
    feh
    appimage-run
    unzip
    wiki-tui
    matrixcli
    
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

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
    prismlauncher
    steam
    lutris
    amidst
    cubiomes-viewer
    minecraft
    heroic
    grapejuice
    superTux
    superTuxKart

    # Gui stuff
    firefox
    chromium

    spotify
    spicetify-cli

    tdesktop
    signal-desktop
    discord
    discocss

    gimp
    kdenlive

    feh
    pavucontrol

    vscode

    qbittorrent

    obs-studio
    arduino
     
    libreoffice

    freetube

    keepassxc

    kicad

    boxes

    # Stooooph
    xmobar
    eww-wayland
    dmenu
    xwallpaper
    hyprpaper
    pscircle
    libsForQt5.qtstyleplugin-kvantum
    dunst
    flameshot
    lxappearance 
    xlockmore
    wine
    playerctl
    filezilla

    socat
    jq
    python3Full
    pfetch
    neofetch
    ranger
    tetex
    unzip
    zlib
    pkg-config
    python310Packages.youtube-dl
    
    cabal-install
    ghc

    papirus-icon-theme
    papirus-folders
    
    # gnome things
    gtk-engine-murrine
    gnome.gnome-tweaks
    gnome.gnome-themes-extra
    gnomeExtensions.blur-my-shell
    gnomeExtensions.vitals
    gnomeExtensions.paperwm
    gnomeExtensions.extension-list
    gnomeExtensions.workspace-indicator-2
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.gsconnect
    # gnomeExtensions.dash-to-dock
    # gnomeExtensions.material-shell
  ];
}

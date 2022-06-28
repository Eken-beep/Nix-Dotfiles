{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "nvidia" ];

  # Hostname
  networking.hostName = "Compootah";

  # Time zone
  time.timeZone = "Europe/Stockholm";

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;
  console.font = "Lat2-Terminus16";

  # Networking
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Automatically use the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Nvidia sucks booooh
  hardware = {
    opengl.driSupport32Bit = true;
    nvidia.modesetting.enable = true;
  };

  # Permitted insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
  ];

  # Xorg and graphical stuff
  services.xserver = {
    enable = true;

    videoDrivers = [ "nvidia" ];

    # Keymap
    layout = "se";
    xkbVariant = "svdvorak, ";
    xkbOptions = "caps:swapescape";

    # WM, DE and displaymanager
    desktopManager = {
      xterm.enable = false;
      gnome.enable = true;
    };

    displayManager = {
      gdm.enable = true;
    };

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
      ];
    };
  };
 
  # Sound
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  # Define a user account.
  users = {
    users.edvin = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
    defaultUserShell = pkgs.zsh;
  };

  # Zsh settings and enable
  programs.zsh.enable = true;

  # Environment
  environment = {
    # Variables
    variables.EDITOR = "nvim";

    pathsToLink = [ "/libexec" ];
  };
  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;

  # Virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "edvin" ];

  # Package list
  environment.systemPackages = with pkgs; [
    
    # Generic
    xterm
    vim
    wget
    git
    jdk11
    jdk17
    killall
    gzip
    zip
    xdotool
    libnotify
    playerctl
    
    # Compilers
    ghc
    gcc
    cabal-install
    stack 
    
    python
     
    rustc 
    cargo

    # Wm stuff
    dmenu
    flameshot
    btop
    htop
    
    # Programms
    firefox
    piper
  ];

  # Fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    liberation_ttf_v1
    fira-code
    fira-code-symbols
    # mplus-outline-fonts
    dina-font
    proggyfonts
    font-awesome
    nerdfonts
    liberation_ttf_v1
    work-sans
    source-sans
    public-sans
    roboto
    roboto-mono
    roboto-slab
    go-font
    sudo-font
    hack-font
    freefont_ttf
    ttf_bitstream_vera
  ];

  # Services
  services = {
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    openssh.enable = true;

    # picom = {
      # enable = true;
      # fade = true;
      # inactiveOpacity = 0.5;
      # shadow = true;
      # fadeDelta = 4;
    # };

    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
    flatpak.enable = true;
    ratbagd.enable = true;
  };

  # ?
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # System version  
  system.stateVersion = "unstable";

}


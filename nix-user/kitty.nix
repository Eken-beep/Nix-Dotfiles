{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      package = pkgs.nerdfonts;
      name = "Iosevka Nerd Font";
      size = 12;
    };
    
    theme = "Molokai";
    # settings = {
    #   setting
    # };

    extraConfig = ''
      XDG_CURRENT_DESKTOP=GNOME
    '';

  };
}

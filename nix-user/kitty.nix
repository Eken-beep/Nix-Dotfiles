{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      package = pkgs.nerdfonts;
      name = "FiraCode Nerd Font";
      size = 12;
    };
    
    theme = "Brogrammer";
    # settings = {
    #   setting
    # };

    extraConfig = ''
      XDG_CURRENT_DESKTOP=GNOME
    '';

  };
}

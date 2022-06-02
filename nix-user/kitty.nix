{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.nerdfonts;
      name = "Iosevka Nerd Font";
      size = 12;
    };
    theme = "Hybrid";
    # settings = {
    #   setting
    # };
    keybindings = {
      "ctrl+shift+j" = "next-window";
      "ctrl+shift+k" = "previous-window";
      # "ctrl+shift+h" = "move-window-backward";
      # "ctrl+shift+l" = "move-window-forward";
    };
  };
}

{ pkgs, ... }:

{
    services.picom = {
    enable = true;
    inactiveOpacity = "0.50";
    activeOpacity = "0.90";
    blur = true;
    experimentalBackends = true;
    opacityRule = [
      "100:class_g   *?= 'Firefox'" 
      "100:class_g   *?= 'Minecraft* 1.18.2'" 
      "75:class_g   *?= 'discord'" 
    ];
    extraOptions = ''
      blur-method = "dual_kawase";
      blur-strength = 8;
      corner-radius = 8;
      round-borders = 1;
      rounded-corners-exclude = [
        "class_g = 'xmobar'",
        "class_g = 'Dunst'",
      ];
    '';
    fade = true;
    fadeDelta = 5;
    package = pkgs.picom.overrideAttrs (
      o: {
        src = pkgs.fetchFromGitHub {
          repo = "picom";
          owner = "ibhagwan";
          rev = "44b4970f70d6b23759a61a2b94d9bfb4351b41b1";
          sha256 = "0iff4bwpc00xbjad0m000midslgx12aihs33mdvfckr75r114ylh";
        };
      }
    );
  };
}

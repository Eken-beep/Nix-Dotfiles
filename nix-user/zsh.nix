{ lib, config, pkgs, commands, ... }:

{
  programs.zsh = {
    enable = true;

    shellAliases = {
      ll = "ls -la";
      e = "nvim";

    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "python" "colored-man-pages" "sudo" "safe-paste" ];
    };

    plugins = [
      { 
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initExtra = ''
      source /home/edvin/.p10k.zsh  
      
    '';
  };
}

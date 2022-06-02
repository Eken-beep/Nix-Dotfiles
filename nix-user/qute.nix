{ config, pkgs, ... }:

{
  programs.qutebrowser = {
    enable = true;

    extraConfig = builtins.readFile ./config.py +
      ''
      c.colors.tabs.selected.odd.fg = '#ffffff'
      c.colors.tabs.selected.even.fg = '#ffffff'
      c.colors.tabs.odd.fg = '#dfdfdf'
      c.colors.tabs.even.fg = '#dfdfdf'
      c.colors.tabs.selected.odd.bg = '#3d85c6'
      c.colors.tabs.selected.even.bg = '#3d85c6'
      c.colors.tabs.odd.bg = '#1f1f1f'
      c.colors.tabs.even.bg = '#1f1f1f'
      c.colors.webpage.bg = '#1f1f1f'
      c.colors.statusbar.normal.bg = '#000000'
      c.colors.statusbar.normal.fg = '#dfdfdf'
      c.colors.statusbar.insert.bg = '#3d85c6'
      c.colors.statusbar.command.fg = '#3d85c6'
    '';
  };
}

{ config, pkgs, ... }:

{
  programs.qutebrowser = {
    enable = true;

    extraConfig = builtins.readFile ./config.py +
      ''
        c.colors.hints.bg = '#3d85c6'
        c.colors.hints.fg = '#dfdfdf'
        c.colors.hints.match.fg = '#1f1f1f'

        c.colors.tabs.selected.odd.fg = '#1f1f1f'
        c.colors.tabs.selected.even.fg = '#1f1f1f'
        c.colors.tabs.selected.odd.bg = '#3d85c6'
        c.colors.tabs.selected.even.bg = '#3d85c6'

        c.colors.tabs.pinned.even.bg = '#c13e63'
        c.colors.tabs.pinned.even.fg = '#dfdfdf'
        c.colors.tabs.pinned.odd.bg = '#c13e63'
        c.colors.tabs.pinned.odd.fg = '#dfdfdf'

        c.colors.tabs.indicator.start = '#c13e63'
        c.colors.tabs.indicator.stop = '#c13e64'

        c.colors.tabs.odd.fg = '#dfdfdf'
        c.colors.tabs.even.fg = '#dfdfdf'
        c.colors.tabs.odd.bg = '#1f1f1f'
        c.colors.tabs.even.bg = '#1f1f1f'

        c.colors.webpage.bg = '#dfdfdf'

        c.colors.completion.category.bg = '#1f1f1f'
        c.colors.completion.category.border.bottom = '#3d85c6'
        c.colors.completion.category.border.top = '#1f1f1f'
        c.colors.completion.category.fg = '#dfdfdf'

        c.colors.completion.fg = '#dfdfdf'
        c.colors.completion.even.bg = '#1f1f1f'
        c.colors.completion.odd.bg = '#2f2f2f'

        c.colors.completion.item.selected.bg = '#3d85c6'
        c.colors.completion.item.selected.border.bottom = '#3d85c6'
        c.colors.completion.item.selected.border.top = '#1f1f1f'
        c.colors.completion.item.selected.fg = '#dfdfdf'
        c.colors.completion.item.selected.match.fg = '#c13e63'
        c.colors.completion.match.fg = '#c13e63'

        c.colors.statusbar.normal.bg = '#1f1f1f'
        c.colors.statusbar.normal.fg = '#dfdfdf'

        c.colors.statusbar.insert.bg = '#3d85c6'

        c.colors.statusbar.command.fg = '#3d85c6'
        c.colors.statusbar.command.bg = '#1f1f1f'

        c.colors.statusbar.url.fg = '#dfdfdf'
        c.colors.statusbar.url.success.https.fg = '#c13e63'
        c.colors.statusbar.url.success.http.fg = '#c13e63'

        c.colors.statusbar.private.bg = '#c13e63'
        c.colors.statusbar.private.fg = '#1f1f1f'

      '';
  };
}

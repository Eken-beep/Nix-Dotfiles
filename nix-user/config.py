############
# Generic
############

config.load_autoconfig()

# Downloads
c.downloads.location.directory = '~/Downloads'
c.downloads.location.prompt = True
c.downloads.position = 'bottom'

c.tabs.show = 'always'
c.statusbar.show = 'always'

# window fullscreen
config.bind('<F10>',
    'config-cycle tabs.show always never;;' +
    'config-cycle statusbar.show always never')

# true fullscreen
config.bind('<F11>',
    'fullscreen;;' +
    'config-cycle tabs.show always never;;' +
    'config-cycle statusbar.show always never')

# Fixing some keys for dvorak
config.bind('e', 'hint', mode='normal')

# Search engine
c.url.searchengines = {
        'DEFAULT':   'https://www.startpage.com/sp/search?query={}'
}

# Startpages
c.url.start_pages = "https://www.startpage.com/"

# Page to open if confuse
c.url.default_page = "https://www.startpage.com/"
c.url.open_base_url = True
c.tabs.last_close = "startpage"

# Statusbar rules
c.statusbar.show = "in-mode"

# Scrolling
c.scrolling.smooth = True

# Darkmode
c.colors.webpage.preferred_color_scheme = "dark"

# Blocking
c.content.blocking.adblock.lists = [ \
        "https://easylist.to/easylist/easylist.txt", \
        "https://easylist.to/easylist/easyprivacy.txt", \
        "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt", \
        "https://easylist.to/easylist/fanboy-annoyance.txt", \
        "https://secure.fanboy.co.nz/fanboy-annoyance.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt" \
        ]

c.content.blocking.enabled = True
c.content.blocking.hosts.lists = ['https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts']
c.content.blocking.method = 'both'

# Hint stuff
c.hints.chars = "aoeuhtns"

############
# Color settings
############

# Setting the color variables
bg = "#1f1f1f"
fg = "#dfdfdf"
prim = "#3d85c6"
sec = "#c13e63"

# Hints
c.colors.hints.bg = prim
c.colors.hints.fg = fg
c.colors.hints.match.fg = bg

# Selected Tab
c.colors.tabs.selected.odd.fg = bg
c.colors.tabs.selected.even.fg = bg
c.colors.tabs.selected.odd.bg = prim
c.colors.tabs.selected.even.bg = prim

# Pinned tab
c.colors.tabs.pinned.even.bg = sec
c.colors.tabs.pinned.even.fg = fg
c.colors.tabs.pinned.odd.bg = sec
c.colors.tabs.pinned.odd.fg = fg

# Tab indicator
c.colors.tabs.indicator.start = sec
c.colors.tabs.indicator.stop = sec

# Tab generics
c.colors.tabs.odd.fg = fg
c.colors.tabs.even.fg = fg
c.colors.tabs.odd.bg = bg 
c.colors.tabs.even.bg = bg

# The completions menu background
c.colors.completion.category.bg = bg
c.colors.completion.category.border.bottom = prim
c.colors.completion.category.border.top = prim
c.colors.completion.category.fg = fg

# Completionsmenu foreground colors
c.colors.completion.fg = fg
c.colors.completion.even.bg = bg
c.colors.completion.odd.bg = '#2f2f2f'

# Completionsmenu selected item properties
c.colors.completion.item.selected.bg = prim
c.colors.completion.item.selected.border.bottom = prim
c.colors.completion.item.selected.border.top = prim
c.colors.completion.item.selected.fg = fg
c.colors.completion.item.selected.match.fg = sec
c.colors.completion.match.fg = sec

# Statusbar settings
c.colors.statusbar.normal.bg = bg
c.colors.statusbar.normal.fg = fg

c.colors.statusbar.insert.bg = prim

# Statusbar command
c.colors.statusbar.command.fg = prim
c.colors.statusbar.command.bg = bg

# Statusbar URL
c.colors.statusbar.url.fg = fg
c.colors.statusbar.url.success.https.fg = sec
c.colors.statusbar.url.success.http.fg = sec

# Private tabs
c.colors.statusbar.private.bg = sec
c.colors.statusbar.private.fg = fg

# Prompts
c.colors.prompts.bg = bg
c.colors.prompts.border = prim
c.colors.prompts.fg = fg

c.colors.prompts.selected.bg = prim
c.colors.prompts.selected.fg = fg

# Downloads colors
c.colors.downloads.bar.bg = bg
c.colors.downloads.error.bg = sec
c.colors.downloads.error.fg = fg
c.colors.downloads.start.bg = prim
c.colors.downloads.stop.bg = "#0e85c6"
c.colors.downloads.start.fg = fg
c.colors.downloads.stop.fg = fg

# Languages that appear in the menu
TRANS_LANGS='ru en sr'

# Menu program.
DMENU='dmenu'

FONT="JetBrains Mono-30"
COLOR_NB="#FEFEFE"
COLOR_NF="#404040"
COLOR_SF="#404040"
COLOR_SB="#93A1A1"

# Commands that are run to display menus.
DMENU_TEXT='dmenu -l 3 -fn "$FONT" -p "Translate:" -nb "$COLOR_NB" -nf "$COLOR_NF" -sf "$COLOR_SF" -sb "$COLOR_SB"'  # select text to translate
DMENU_LANG='dmenu -l 3 -fn "$FONT" -p "Translate into:" -nb "$COLOR_NB" -nf "$COLOR_NF" -sf "$COLOR_SF" -sb "$COLOR_SB"'  # select language to translate to
DMENU_NEXT='dmenu -l 3 -fn "$FONT" -p "Translation done" -nb "$COLOR_NB" -nf "$COLOR_NF" -sf "$COLOR_SF" -sb "$COLOR_SB"'  # select what to do with the translation

# Set this to any value if you want to always copy the
# translation (skips DMENU_NEXT menu).
ALWAYS_COPY=

# Clipboard command must receive text from standard input
CLIP_CMD='xclip -i -r -selection clipboard'

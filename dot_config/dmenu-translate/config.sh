# Languages that appear in the menu
TRANS_LANGS='ru en sr'

# Menu program.
DMENU='bemenu'

FONT="JetBrains Mono 18"
COLOR_TB="#141c21"
COLOR_TF="#93a1a1"
COLOR_HF="#010101"
COLOR_HB="#5294E2"

# Commands that are run to display menus.
DMENU_TEXT='bemenu -l 3 --fn "$FONT" -p "Translate:" --tb "$COLOR_TB" --tf "$COLOR_TF" --hf "$COLOR_HF" --hb "$COLOR_HB"'  # select text to translate
DMENU_LANG='bemenu -l 3 --fn "$FONT" -p "Translate into:" --tb "$COLOR_TB" --tf "$COLOR_TF" --hf "$COLOR_HF" --hb "$COLOR_HB"'  # select language to translate to
DMENU_NEXT='bemenu -l 3 --fn "$FONT" -p "Translation done" --tb "$COLOR_TB" --tf "$COLOR_TF" --hf "$COLOR_HF" --hb "$COLOR_HB"'  # select what to do with the translation

# Set this to any value if you want to always copy the
# translation (skips DMENU_NEXT menu).
ALWAYS_COPY=

# Clipboard command must receive text from standard input
CLIP_CMD='xclip -i -r -selection clipboard'

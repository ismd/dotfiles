# ------------------------------------------------------------------------------
# Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>
#
# Landscape Theme
# ------------------------------------------------------------------------------

# Colors
background='#141c21'
foreground='#93a1a1'
color0='#263640'
color1='#d12f2c'
color2='#819400'
color3='#b08500'
color4='#2587cc'
color5='#696ebf'
color6='#289c93'
color7='#bfbaac'
color8='#4a697d'
color9='#fa3935'
color10='#a4bd00'
color11='#d9a400'
color12='#2ca2f5'
color13='#8086e8'
color14='#33c5ba'
color15='#fdf6e3'

accent='#5294E2'
element_bg='#141c21'
element_fg='#93a1a1'
dunst_element_bg='#FEFEFE'
dunst_element_fg='#404040'

light_value='0.40'
dark_value='0.10'

# Wallpaper
wdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
wallpaper="$wdir/wallpaper"

# Polybar
#polybar_font='Iosevka Nerd Font:size=10;3'
{%@@ if profile == "cz-work" @@%}
polybar_font='JetBrains Mono:size=10;3'
{%@@ else @@%}
polybar_font='JetBrains Mono:size=15;3'
{%@@ endif @@%}

# Rofi
{%@@ if profile == "cz-work" @@%}
rofi_font='Iosevka 10'
{%@@ else @@%}
rofi_font='Iosevka 22'
{%@@ endif @@%}
rofi_icon='Qogir'

# Terminal
terminal_font_name='JetBrainsMono Nerd Font'
{%@@ if profile == "cz-work" @@%}
terminal_font_size='15'
{%@@ else @@%}
terminal_font_size='22'
{%@@ endif @@%}

# Geany
geany_colors='beach.conf'
{%@@ if profile == "cz-work" @@%}
geany_font='JetBrains Mono 15'
{%@@ else @@%}
geany_font='JetBrains Mono 22'
{%@@ endif @@%}

# Appearance
{%@@ if profile == "cz-work" @@%}
gtk_font='Noto Sans 12'
{%@@ else @@%}
gtk_font='Noto Sans 16'
{%@@ endif @@%}
gtk_theme='Arc-Lighter'
#icon_theme='Qogir'
icon_theme='neru-newyear-light'
cursor_theme='Qogirr-Dark'

# Dunst
dunst_width='360'
dunst_height='240'
dunst_offset='24x60'
dunst_font='JetBrains Mono 12'
dunst_origin='top-right'
dunst_border='0'
dunst_separator='2'

# Picom
picom_backend='glx'
picom_corner='0'
picom_shadow_r='14'
picom_shadow_o='0.30'
picom_shadow_x='-12'
picom_shadow_y='-12'
picom_blur_method='none'
picom_blur_strength='0'

# I3WM
i3wm_fonts='JetBrainsMono Nerd Font 12'
i3wm_border_size='2'
i3wm_border_style='pixel'
i3wm_gaps_inner='6'
i3wm_gaps_outer='0'
i3wm_gaps_smart='off'

"""Tab bar: rounded pill for the active tab, plain text for the rest."""

from kitty.fast_data_types import Screen
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb, draw_title

LEFT_CAP = '\ue0b6'
RIGHT_CAP = '\ue0b4'
GAP = ' '


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    tab_bg = screen.cursor.bg
    tab_fg = screen.cursor.fg
    default_bg = as_rgb(int(draw_data.default_bg))

    def draw_cap(symbol: str) -> None:
        if tab.is_active:
            screen.cursor.fg = tab_bg
            screen.cursor.bg = default_bg
        screen.draw(symbol if tab.is_active else ' ')
        screen.cursor.fg = tab_fg
        screen.cursor.bg = tab_bg

    draw_cap(LEFT_CAP)
    draw_title(draw_data, screen, tab, index, max_tab_length)
    # Leave room for the right cap within max_tab_length.
    extra = screen.cursor.x + 1 - before - max_tab_length
    if extra > 0:
        screen.cursor.x -= extra + 1
        screen.draw('…')
    draw_cap(RIGHT_CAP)

    end = screen.cursor.x
    if not is_last and end < screen.columns:
        screen.cursor.bg = default_bg
        screen.draw(GAP)
    return end

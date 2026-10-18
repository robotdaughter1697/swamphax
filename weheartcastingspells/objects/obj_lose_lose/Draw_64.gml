draw_set_font(start_font);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed(
    display_get_gui_width() / 2,
    175,
    "The Wizard defeated you...",
    3, 3, 0
);

draw_text_transformed(
    1100,
    530,
    "RETRY ---->",
    3, 3, 0
);
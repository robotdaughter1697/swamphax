draw_set_font(start_font);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed(
   -camera_get_view_x(view_camera[0]) + display_get_gui_width() / 2,
     -camera_get_view_y(view_camera[0]) + 175,
    "run, young apprentice!",
    3, 3, 0
);

draw_text_transformed(
    -camera_get_view_x(view_camera[0]) + 1100,
    -camera_get_view_y(view_camera[0]) + 589,
    "START ---->",
    3, 3, 0
);
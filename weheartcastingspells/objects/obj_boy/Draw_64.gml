function render_spell_warning(
	text, 
	alpha
) {
	draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_color(c_red);
    draw_set_alpha(alpha)

    draw_text_transformed(
        display_get_gui_width() / 2,
        display_get_gui_height() / 4,
        text,
        4, 4, 20 * sin(2 * get_timer() / 1000000)
    );

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

if (show_show = 1) {
	if (mana < 50){
	    draw_set_color(c_white);
		draw_set_halign(fa_center);

		draw_text(
        display_get_gui_width() / 2,
        display_get_gui_height() / 2,
        "you are too weak. get more mana"
		);
	}else{
		room_goto_next();
	}

    draw_set_halign(fa_left);
}

if (wind_timer > 0) {
    render_spell_warning("Wizard casted Wind!", wind_timer / STARTING_WIND_TIME)
}
if (burn_timer > 0) {
    render_spell_warning("Wizard casted Fire!", burn_timer / STARTING_BURN_TIME)
}
if (lightning_timer > 0) {
    render_spell_warning("Wizard casted Lightning!", lightning_timer / STARTING_LIGHTNING_TIME)
}
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha)

#macro MANA_BAR_WIDTH (camera_get_view_width(view_camera[0]) * 0.15)
#macro MANA_BAR_HEIGHT (camera_get_view_height(view_camera[0]) * 0.045)
#macro MANA_BAR_LEFT (camera_get_view_width(view_camera[0]) * 0.05)
#macro MANA_BAR_TOP (camera_get_view_height(view_camera[0]) * 0.90)

draw_healthbar(
	MANA_BAR_LEFT + camera_get_view_x(view_camera[0]), 
	MANA_BAR_TOP + camera_get_view_y(view_camera[0]), 
	MANA_BAR_LEFT + MANA_BAR_WIDTH + camera_get_view_x(view_camera[0]),
	MANA_BAR_TOP + MANA_BAR_HEIGHT + camera_get_view_y(view_camera[0]), 
	mana, 
	make_colour_rgb(0, 0, 0),  // discarded
	make_colour_rgb(125, 125, 125), 
	make_colour_rgb(245, 243, 147), 
	0, 
	true, 
	false
)

draw_set_colour(c_navy)
draw_set_font(mana_font)

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed(
	camera_get_view_x(view_camera[0]) + MANA_BAR_LEFT + 60, 
	camera_get_view_y(view_camera[0]) + MANA_BAR_TOP + 10, 
	"mana", 
	1.4, 1.3, 
	1.6 * sin(0.8 * get_timer() / 1000000)
)

draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_set_font(start_font)
draw_set_colour(c_white)

// probably not worth the time!
//wind_lines = []

//if (wind_timer > 0) {
//	if (random(2)) {
//		length = 15 + random(20)
//		origin = [
//			random(camera_get_view_width(view_camera[0])), 
//			random(camera_get_view_height(view_camera[0]))
//		]
		
//		array_push(wind_lines, { length: length, origin: origin })
//	}
	
//	for (var i = 0; i < array_length(wind_lines); ++i) {
//		draw_line_width_colour(
//			wind_lines[i].origin[0], 
//			wind_lines[i].origin[1], 
//			wind_lines[i].origin[0] + wind_lines[i].length, 
//			wind_lines[i].origin[1], 
//			8, 
//			c_white, 
//			c_blue
//		)
//	}
//}

for (var i = 0; i < array_length(future_lightning_locations); ++i) {
	draw_set_colour(c_yellow)
	draw_set_alpha(0.3 * ((future_lightning_locations[i].time_alive / 1000000) / (LIGHTNING_WARNING_TIME)))

	draw_line_width(
		floor(future_lightning_locations[i].location), 
		floor(view_get_xport(view_camera[0])), 
		floor(future_lightning_locations[i].location), 
		floor(view_get_xport(view_camera[0]) + view_get_hport(view_camera[0])), 
		LIGHTNING_HORIZONTAL_LENGTH - LIGHTNING_HORIZONTAL_LENGTH * ((future_lightning_locations[i].time_alive / 1000000.) / LIGHTNING_WARNING_TIME) 
	)
	
	future_lightning_locations[i].time_alive += delta_time
	
	if ((future_lightning_locations[i].time_alive / 1000000.) > LIGHTNING_WARNING_TIME) {
		if (
			x > future_lightning_locations[i].location - LIGHTNING_REAL_HORIZONTAL_LENGTH &&
			x < future_lightning_locations[i].location + LIGHTNING_REAL_HORIZONTAL_LENGTH
		) {
			stun_duration_left = LIGHTNING_STUN_DURATION
		}
		
		array_delete(future_lightning_locations, i, 1)
	}
	
	draw_set_alpha(1)
}
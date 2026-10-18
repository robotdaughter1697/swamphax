
var old_position = [
	camera_get_view_x(view_camera[0]), 
	camera_get_view_y(view_camera[0])
]

var old_size = [
	camera_get_view_width(view_camera[0]), 
	camera_get_view_height(view_camera[0])
]

var goal_position
if (room == rm_tower) {
	goal_position = [
		32 * obj_boy.velocity[0] + obj_boy.x - old_size[0] / 2, 
		15 * obj_boy.velocity[1] + obj_boy.y - old_size[1] / 2
	]
} 
else {
	goal_position = [
		32 * obj_boy.velocity[0] + obj_boy.x - old_size[0] / 2, 
		15 * obj_boy.velocity[1] + obj_boy.y / 1.35 - old_size[1] / 2
	]
}

var goal_size = [
	view_wport[0] / 1.7, 
	view_hport[1] / 1.7
]

// holy moly; adjust if needed
var new_position = [
	lerp(old_position[0], goal_position[0], 0.06), 
	lerp(old_position[1], goal_position[1], 0.02)
]
if (room == rm_start || room == rm_lose || room = rm_win) {
	new_position = [
		clamp(new_position[0], 0, view_wport[0]), 
		clamp(new_position[1], 0, view_hport[0])
	]
}
if (room == rm_main) {
	new_position = [
		clamp(new_position[0], 0, 5020 - 800), 
		clamp(new_position[1], 0, view_hport[0])
	]
}

var new_size = [
	lerp(old_size[0], goal_size[0], 0.1), 
	lerp(old_size[1], goal_size[1], 0.1), 
]

camera_set_view_pos(view_camera[0], new_position[0], new_position[1])
camera_set_view_size(view_camera[0], new_size[0], new_size[1])
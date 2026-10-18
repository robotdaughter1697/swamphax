view_enabled = true
view_visible[0] = true

view_xport[0] = 0
view_yport[0] = 0

view_wport[0] = display_get_width()
view_hport[0] = display_get_height()

view_camera[0] = camera_create_view(
	view_xport[0], view_yport[0], 
	view_wport[0], view_hport[0]
)

var display_width = display_get_width()
var display_height = display_get_height()
var center = [
	display_width / 2 - view_wport[0] / 2, 
	display_height / 2 - view_hport[0] / 2
]

window_set_rectangle(center[0], center[1], view_wport[0], view_hport[0])
surface_resize(application_surface, view_wport[0], view_hport[0])
window_set_fullscreen(true)

/*
settings for camera tracking and zoom: 
should be here, but they're in step (:
*/
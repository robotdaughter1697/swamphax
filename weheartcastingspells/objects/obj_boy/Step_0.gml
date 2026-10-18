

if (abs(velocity[0]) < VELOCITY_EPSILON) {
	velocity[0] = 0.
}
if (abs(velocity[1]) < VELOCITY_EPSILON) {
	velocity[1] = 0.
}
show_show = place_meeting(x, y, obj_wizard);

var dir;
if (stun_duration_left > 0) {
	dir = [0, 0]
}
else {
	dir = [
		(keyboard_check(ord("D")) || keyboard_check(vk_right)) - (keyboard_check(ord("A")) || keyboard_check(vk_left)),
		(keyboard_check(ord("S")) || keyboard_check(vk_down)) - (keyboard_check(ord("W")) || keyboard_check(vk_up))
	]
}

// TD rename to key dir; too late

var force = [0., 0.]

if (dir[0] != 0) {
	facing = dir[0]
}

if (dir[0] != 0) {
	if (is_on_ground) {
		force[0] += HORIZONTAL_GROUND_FORCE_ON_KEY * dir[0]
	}
	else {
		force[0] += HORIZONTAL_AIR_FORCE_ON_KEY * dir[0]
	}
}

if (is_on_ground && dir[1] == -1) {
	force[1] -= VERTICAL_FORCE_ON_JUMP
	force[0] += HORIZONTAL_FORCE_BOOST_ON_JUMP_ADD * sign(velocity[0])
}
if (slam_available && not is_on_ground && dir[1] == 1) {
	force[1] += VERTICAL_FORCE_ON_SLAM
	slam_available = false
	in_slam = true
}

// temp stun
if (keyboard_check(ord("V"))) {
	stun_duration_left = LIGHTNING_STUN_DURATION
}

//wind

if (keyboard_check(ord("Y"))){
	wind_timer = STARTING_WIND_TIME
}

if (wind_timer > 0) {
    // HORIZONTAL_GROUND_FORCE_ON_KEY = 0.9;
    wind_timer--;
	
	force[0] -= WIND_FORCE;
}
else {
    // HORIZONTAL_GROUND_FORCE_ON_KEY = 2.5;
}

//fire

if (keyboard_check(ord("U"))){
	burn_timer = STARTING_BURN_TIME;
	burning = true;
	jitter_timer = 0;
}

if (burn_timer > 0){
	burn_timer--;
	jitter_timer++;
	
	image_blend = c_red;
	  if (jitter_timer >= 3) {
        jitter_x = random_range(-4, 4);
        jitter_y = random_range(-4, 4);
        jitter_timer = 0;
		x += jitter_x;
		y += jitter_y;
    }

    // Stop burning
    if (burn_timer <= 0) {
        is_burning = false;
        image_blend = c_white;

        jitter_x = 0;
        jitter_y = 0;
    }
}

// lightning

if (keyboard_check(ord("L"))) {
	lightning_timer = STARTING_LIGHTNING_TIME 
	// future_lightning_locations = []
}


if (lightning_timer > LIGHTNING_WARNING_TIME) {
	if (random(1.) < 0.06) {
		var jazzy = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])
		location = 2 * (random(jazzy) - jazzy / 4)
		
		array_push(future_lightning_locations, { location: location, time_alive: 0 })
	}
	
	--lightning_timer;
}

force[1] += GRAVITY_FORCE * mass

if (in_slam) {
	force[0] *= HORIZONTAL_FORCE_DAMP_WHILE_SLAM_MULT	
}

var acceleration = [force[0] / mass, force[1] / mass]

if (is_on_ground) {
	velocity[0] += acceleration[0] - HORIZONTAL_GROUND_FRICTION_COEFFICIENT * velocity[0]
}
else {
	velocity[0] += acceleration[0] - HORIZONTAL_AIR_FRICTION_COEFFICIENT * velocity[0]
}

velocity[1] += acceleration[1]

var proposed_x = x + velocity[0]
var proposed_y = y + velocity[1]

var vertical_collider = instance_place(
    x, proposed_y,
    [obj_platform, obj_jump, obj_tower_col]
);

if (vertical_collider != noone) {
    if (velocity[1] > 0) {
        // Moving downward: land on top
        y = vertical_collider.bbox_top - (bbox_bottom - y);
        is_on_ground = true;
        slam_available = true;
        in_slam = false;

        if (in_slam) facing = 0;
    }
    else if (velocity[1] < 0) {
        // Moving upward: hit the underside
        y = vertical_collider.bbox_bottom - (bbox_top - y);
    }

    velocity[1] = 0;
}
else {
    y = proposed_y;
    is_on_ground = false;
}

var horizontal_collider = instance_place(proposed_x, y, [obj_platform, obj_jump, obj_tower_col])
if (horizontal_collider) {
	if (proposed_x < horizontal_collider.bbox_left) {
		velocity[0] = 0
		x = horizontal_collider.x - sprite_width
	}
	if ((proposed_x + sprite_width) > horizontal_collider.bbox_right) {
		velocity[0] = 0
		x = horizontal_collider.bbox_right
	}
}
else {
	x = proposed_x
}

if (mana_cooldown > 0) {
    mana_cooldown--;
}

if (place_meeting(x, y, obj_potion) && mana_cooldown <= 0) {
    with (obj_potion) {
        if (place_meeting(x, y, other)) {
            instance_destroy();
        }
    }
	
    mana += 10;
    mana_cooldown = room_speed;
}

if (instance_place(x, y, [obj_platform, obj_jump, obj_tower_col])) {
	show_debug_message("THIS SHOULDN'T HAPPEN")	
}

if (velocity[0] == 0 && velocity[1] == 0) {
	time_since_movement += delta_time	
}
else {
	time_since_movement = 0
}

if (time_since_movement > (2. * 1000000)) {  // dt in us
	sprite_index = boy_down
}
else if (not is_on_ground) {
	if (velocity[0] < 0) {
		sprite_index = boy_left_jump
	}
	if (velocity[0] > 0) {
		sprite_index = boy_right
	}
}
else {
	if (facing == 0) {
		sprite_index = boy_sprite
	}
	else {
		if (velocity[0] == 0) {
			image_index = 0
		}
		
		if (facing < 0) {
			sprite_index = boy_left
		}
		if (facing > 0) {
			sprite_index = boy_right_jump
		}
	}
}

if (stun_duration_left > 0) {
	--stun_duration_left;
	
	if (stun_duration_left == 0) {
		image_blend = c_white;	
	}
	else {
		image_blend = c_blue;
	}
}


if (y > room_height + 100) {

    var spawn = instance_find(obj_spawn, 0);

    if (spawn != noone) {
        x = spawn.x;
        y = spawn.y;

        velocity = [0, 0];
        is_on_ground = false;
        in_slam = false;
    }
}
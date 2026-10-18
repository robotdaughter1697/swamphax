if (countdown > 0) {
    countdown--;
}

if (countdown <= 0 && !timer_finished) {
    timer_finished = true;
    room_goto(rm_lose);
	instance_destroy();
}
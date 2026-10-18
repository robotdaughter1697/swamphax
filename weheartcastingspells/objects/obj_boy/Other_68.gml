if (async_load[? "type"] == network_type_data)
{
    var buf = async_load[? "buffer"];
    buffer_seek(buf, buffer_seek_start, 0);
    var spell = buffer_read(buf, buffer_string);

    show_debug_message("spell received: " + spell);

    if (spell == "WATER")     { global.cast_water = true }
    if (spell == "FIRE")      { global.cast_fire = true }
    if (spell == "WIND")      { global.cast_wind = true }
    if (spell == "LIGHTNING") { global.cast_lightning = true }
}
///c_imaging();

if global.shower != s_solid {
    sprite_delete(global.shower);
}

var me = buffer_base64_decode(argument0);
buffer_save(me, "bitchin.png");
global.shower = sprite_add("bitchin.png", 1, false, false, 0, 0);

///st_standard();
//you know the drill

if hput != 0 {
    hspd += hput * acc;
    hspd = clamp(hspd, -maxhspd, maxhspd);
} else {
    hspd = lerp(hspd, 0, frict);
    image_index = 0;
}

if(abs(hspd) < 0.2 and !aerial){
    hspd = 0;
}

if place_meeting(x + hspd, y, o_solid) {
    var i = 0;
    while !place_meeting(x + sign(hspd), y, o_solid) {
        x += sign(hspd);
        i++;
        if i > sprite_width { break; } 
    }
    hspd = 0;
}


if vspd < 0 {
    if (jumpr) {
        vspd = vspd / 2;
    }
}

if left {
    dir = 1;
}
if right {
    dir = -1;
}



if !place_meeting(x, y + 1, o_solid) {
    vspd += grav;
    leniance -= .5;
    image_index = 1;
} else {
    leniance = 5;
    aerial = false; 
    dashed = false;
    //y = floor(y);
    vspd = 0;
    if down {
        hspd = 0;
    }
    dashed = false;
    image_speed = hspd/15;
}

if place_meeting(x, y + vspd, o_solid) {
    while !place_meeting(x, y + sign(vspd), o_solid) {
        y += sign(vspd);
    }
    vspd = 0;
    
}

if leniance > 0 || aerial < 2 {
    if (jump) {
        vspd = jspd;
        leniance = 0;
        aerial++;
    }
}

x += hspd;
y += vspd;

if instance_place(x, y, o_damage) && !inv {
    alarm[0] = 30;
    inv = true;
    image_alpha = .5;
    image_blend = c_red;
    vspd = -3;
    hp -= instance_place(x, y, o_damage).damage;
}

image_xscale = size*dir;
image_yscale = size;

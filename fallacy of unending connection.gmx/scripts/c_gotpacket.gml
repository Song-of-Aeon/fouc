///c_gotpacket();
var buffer = argument[0];
//message_id = buffer_read buffer_read(buffer, buffer_f16);

/*switch type {
    case 
}*/
/*
//console_log("almost");
//MOON.x = buffer_read(buffer, buffer_f32);
//MOON.y = buffer_read(buffer, buffer_f32);
//console_log("nice");


console_log(buffer_read(buffer, buffer_string));
//console_log("yet rending");

//console_log(buffer_base64_decode(buffer_read(buffer, buffer_string)));*/

c_imaging(buffer_read(buffer, buffer_string));

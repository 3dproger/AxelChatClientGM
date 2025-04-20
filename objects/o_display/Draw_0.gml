draw_set_font(Font1);
draw_set_valign(fa_bottom)

var text = "";

if (o_axelchat_client.connected)
{
	text += console_text + "\n" +
	"==================================\n" +
	"Info: " + state_info + "\n" +
	"State: " + state_text;
}
else
{
	text += "Not connected to AxelChat";
}

draw_text(0, room_height, text);

draw_set_valign(fa_top)
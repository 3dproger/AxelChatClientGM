function src_on_axelchat_connected(info)
{
	var text = "Connected to " + info.app_name + " " + info.app_version;	
	o_axelchat_display.state_info = text;
}
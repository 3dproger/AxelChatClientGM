function src_on_axelchat_message_received(message)
{
	o_axelchat_display.console_text += src_message_to_string(message) + "\n";
}

function src_message_to_string(message)
{
	var author = src_axelchat_message_get_author(message);
	var result = "[" + src_axelchat_user_get_service_id(author) + "] " + src_axelchat_user_get_name(author) + ": ";
	
	result += src_axelchat_message_get_contents_as_text(message);

	return result;
}
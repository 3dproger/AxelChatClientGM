function src_process_event(json)
{
	var type = json.type;
	
	if (type == "HELLO") // событие приходит при подключении к AxelChat
	{
		var text = "Connected to " + json.data.app_name + " " + json.data.app_version;
		
		o_display.state_info = text;
	}
	else if (type == "STATES_CHANGED") // событие приходит переодически от AxelChat и содержит информацию о различных состояний
	{
		var text = "";
		
		text += "viewers: " + string(json.data.viewers);
		
		for (var i = 0; i < array_length(json.data.services); i++)
		{
			var service = json.data.services[i];
			
			if (service.enabled)
			{
				text += "\n    [" + service.type_id + "]: ";
			
				text += "connection_state: " + service.connection_state;
				text += ", "
				text += "enabled: " + string(service.enabled);
				text += ", "
				text += "viewers: " + string(service.viewers);
			}
		}
		
		o_display.state_text = text;
	}
	else if (type == "NEW_MESSAGES_RECEIVED") // событие приходит, когда пришло новое сообщение
	{
		for (var i = 0; i < array_length(json.data.messages); i++)
		{
			var message = json.data.messages[i];
			o_display.console_text += parse_message(message) + "\n";
		}
	}
	else if (type == "MESSAGES_SELECTED" ||
			 type == "SETTINGS_UPDATED")
	{
		// TODO: Not implemented
	}
	else
	{
		show_debug_message("Unknown event type \"" + type + "\"");
	}
}

function parse_message(message)
{
	var author = axelchat_message_get_author(message);
	var result = "[" + axelchat_user_get_service_id(author) + "] " + axelchat_user_get_name(author) + ": ";
	
	result += axelchat_message_get_contents_as_text(message);

	return result;
}
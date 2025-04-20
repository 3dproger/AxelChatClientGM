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
			o_display.console_text += parse_message(json.data.messages[i]) + "\n";
		}
	}
	else if (type == "MESSAGES_SELECTED" ||
			 type == "SETTINGS_UPDATED")
	{
		// not implemented
	}
	else
	{
		show_debug_message("Unknown event type \"" + type + "\"");
	}
}

function parse_message(json)
{
	var result = "[" + json.author.serviceId + "] " + json.author.name + ": ";
	
	for (var i = 0; i < array_length(json.contents); i++)
	{
		var content = json.contents[i];
		var type = content.type;
		if (type == "text")
		{
			result += content.data.text;
		}
		else if (type == "hyperlink")
		{
			result += content.data.text;
		}
		else if (type == "image")
		{
			result += "[IMAGE]";
		}
		else if (type == "html")
		{
			result += "[HTML]";
		}
		else
		{
			show_debug_message("Unknown content type \"" + type + "\"");
		}
	}
	
	return result;
}
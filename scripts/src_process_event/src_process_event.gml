function src_process_event(json)
{
	var type = json.type;
	
	if (type == "STATES_CHANGED") // событие приходит переодически от AxelChat и содержит информацию о различных состояний
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
		
		o_AxelChat_display.state_text = text;
	}
}

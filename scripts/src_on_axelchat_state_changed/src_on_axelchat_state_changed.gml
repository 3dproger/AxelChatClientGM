function src_on_axelchat_state_changed(state)
{
	var text = "";
		
	text += "viewers: " + string(state.viewers);
		
	for (var i = 0; i < array_length(state.services); i++)
	{
		var service = state.services[i];
			
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
		
	o_axelchat_display.state_text = text;
}
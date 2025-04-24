var type_event = ds_map_find_value(async_load, "type");
if (type_event == network_type_non_blocking_connect)
{
	// Connected to WebSocket
	send_client_info();
}
else if (type_event == network_type_disconnect)
{
	// WebSocket disconnected
	show_debug_message("Socket disconnected");
	disconnect();
}
else if (type_event == network_type_data)
{
	// Received data via WebSocket
	
	connected = true; // So we are connected to AxelChat
	
	var buffer = ds_map_find_value(async_load, "buffer"); // Getting a network buffer for reading
	var raw_data = buffer_read(buffer, buffer_string); // Reading text data from the buffer
	//show_debug_message(raw_data); // Uncomment if you want to output the received data to the console
	var event = json_parse(raw_data); // Turning a JSON string into a GM-structure
	var type = event.type;
	var data = event.data;
	
	if (type == "PING")
	{
		send_pong(); // We notify the server that we are still connected to it
	}
	else if (type == "PONG")
	{
		// Everything is fine, so the server is available
	}
	else if (type == "SERVER_CLOSE")
	{
		show_debug_message("Server closed");
		disconnect();
	}
	else if (type == "NEED_RELOAD")
	{
		show_debug_message("Reload received, disconnect");
		disconnect();
	}
	else
	{
		process_event(type, data);
	}
	
	alarm[1] = server_ping_timeout; // If after this time no new data arrives, then the server is already closed
}
else
{
	show_debug_message("Unknwon network event type " + string(type_event))
}
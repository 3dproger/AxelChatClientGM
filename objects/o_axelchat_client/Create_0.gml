connected = false; // The variable stores the state of whether we are connected to server
socket = -1; // socket id through which we connect to server
buffer = buffer_create(16384, buffer_grow, 2); // A buffer that is used to send data to the server
server_ping_timeout = 1000;
alarm[0] = 10;

/// @description Function to try to connect to the server
function connect()
{
	if (connected)
	{
		return;
	}
	
	disconnect(); // Disconnect or reset the previous connection, if there was one
	socket = network_create_socket(network_socket_ws); // Create a WebSocket for communication with the server
	network_connect_raw_async(socket, server_address, server_port); // Trying to connect to the server
}

/// @description Function to disconnect from the server and/or to reset the connection state when the connection is broken
function disconnect()
{
	connected = false; // Resetting the connection state
	if (socket != -1)
	{
		network_destroy(socket); // Close socket connection
		socket = -1; // Reset socket id
	}
}

/// @description Sends information about the client so that the server knows who has connected to it
function send_client_info()
{
	var message = {
		data: {
			client: {
				name: game_display_name,
				version: GM_version,
				type: "MAIN_WEBSOCKETCLIENT",
				device: {
					type: "some_device", // TODO: Not implemented
					name: "Some device", // TODO: Not implemented
					os: {
						name: "some_os", // TODO: Not implemented
						version: "unknown", // TODO: Not implemented
					}
				}
			},
			info: {
				name: game_project_name,
				type: "GENERIC"
			},
		},
		type: "HELLO"
	};
	
	if (os_browser != browser_not_a_browser)
	{
		var browser = {
			name: string(os_browser), // TODO: Not implemented
			version: "unknown", // TODO: Not implemented
		};
		
		struct_set(message.data.client.device, "browser", browser);
	}
	
	src_network_utils_send_as_json(socket, buffer, message);
}

// @descriptio The function is used to ask the server if it is available
function send_ping()
{
	var message = {
		type: "PING"
	};
	
	src_network_utils_send_as_json(socket, buffer, message);
}

/// @description The function is used to notify that we are still connected to it
function send_pong()
{
	var message = {
		type: "PONG"
	};
	
	src_network_utils_send_as_json(socket, buffer, message);
}

/// @description The function is used to process event from server
/// @param {String} type Event type
/// @param {Struct} data Event data
function process_event(type, data)
{
	if (type == "NEW_MESSAGES_RECEIVED")
	{
		if (script_exists(on_message_received_script))
		{
			var messages = data.messages;
			for (var i = 0; i < array_length(messages); i++)
			{
				var message = messages[i];
				script_execute(on_message_received_script, message);
			}
		}
		else
		{
			show_debug_message("Script 'on_message_received_script' not assigned");
		}
	}
	else if (type == "STATES_CHANGED")
	{
		if (script_exists(on_state_changed))
		{
			script_execute(on_state_changed, data);
		}
		else
		{
			show_debug_message("Script 'on_state_changed' not assigned");
		}
	}
	else if (type == "HELLO")
	{
		if (script_exists(on_connected_script))
		{
			script_execute(on_connected_script, data);
		}
		else
		{
			show_debug_message("Script 'on_connected_script' not assigned");
		}
	}
	else if (type == "MESSAGES_SELECTED" ||
			 type == "SETTINGS_UPDATED" ||
			 type == "USER_UPDATED" ||
			 type == "MESSAGES_CHANGED" ||
			 type == "MESSAGES_REMOVED" ||
			 type == "SETTINGS_UPDATED" ||
			 type == "CLEAR_MESSAGES")
	{
		// TODO: Not implemented
	}
	else
	{
		show_debug_message("Unknwon event type '" + type + "'");
	}
}
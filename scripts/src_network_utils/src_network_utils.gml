/// @description					Sends struct or array as JSON to socket
/// @param {Id.Socket} socket_id	ID of an existing and connected socket
/// @param {Id.Buffer} buffer_id	ID of an existing buffer
/// @param {Struct | Array} struct_or_array	The structure or array that will be converted to JSON and sent to the socket
/// @param {Bool} prettify			Whether to prettify the JSON, i.e. insert indentation and line breaks for readability
///	@return {Bool}					Returns true if successful, otherwise falls
function network_send_as_json(socket_id, buffer_id, struct_or_array, prettify = false)
{
	if (!is_struct(struct_or_array) && !is_array(struct_or_array))
	{
		show_debug_message("This is not struct or array");
		return false;
	}

	var json = json_stringify(struct_or_array, prettify);
	buffer_seek(buffer_id, buffer_seek_start, 0);
	if (buffer_write(buffer_id, buffer_string, json) == -1)
	{
		show_debug_message("Failed to write to buffer");
		return false;
	}
	
	network_send_raw(socket_id, buffer_id, string_byte_length(json), network_send_text);
	
	return true;
}

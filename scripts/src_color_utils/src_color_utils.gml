/// @description Converts hexadecimal color as string to color as number
/// @param {String} hex_color Hexadecimal color. The symbol '#' in start of string is allowed
///	@return {Real}
function src_color_utils_hex_to_color(hex_color)
{
	if (string_starts_with(hex_color, "#"))
	{
		hex_color = string_delete(hex_color, 1, 1);
	}
	
    var dec = src_string_utils_hex_to_dec(hex_color);
    return (dec & 16711680) >> 16 | (dec & 65280) | (dec & 255) << 16;
}

/// @description Converts color as number to hexadecimal color as string
/// @param {Real} color Color
/// @param {Bool} add_hash_symbol Need to add hash symbol in begin of string
///	@return {String}
function src_color_utils_color_to_hex(color, add_hash_symbol = true)
{
    var dec = (color & 16711680) >> 16 | (color & 65280) | (color & 255) << 16;
    var result = src_string_utils_dec_to_hex(dec);
	
	if (add_hash_symbol)
	{
		result = "#" + result;
	}
	
	return result;
}
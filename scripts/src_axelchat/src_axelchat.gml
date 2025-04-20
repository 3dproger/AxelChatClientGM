/// @description Get author of message
/// @param {Struct} message Message
///	@return {Struct}
function axelchat_message_get_author(message)
{
	return message.author;
}

/// @description Get service id of user
/// @param {Struct} user User
///	@return {String}
function axelchat_user_get_service_id(user)
{
	return user.serviceId;
}

/// @description Get name of user
/// @param {Struct} user User
///	@return {String}
function axelchat_user_get_name(user)
{
	return user.name;
}

/// @description Get id of user
/// @param {Struct} user User
///	@return {String}
function axelchat_user_get_id(user)
{
	return user.id;
}

/// @description Get avatart URL of user
/// @param {Struct} user User
///	@return {String}
function axelchat_user_get_avatar_url(user)
{
	return user.avatar;
}

/// @description Get page URL of user
/// @param {Struct} user User
///	@return {String}
function axelchat_user_get_page_url(user)
{
	return user.pageUrl;
}

/// @description Get service bage URL of user
/// @param {Struct} user User
///	@return {String}
function axelchat_user_get_service_badge_url(user)
{
	return user.serviceBadge;
}

/// @description Get nickname text color of user or -1
/// @param {Struct} user User
///	@return {Real}
function axelchat_user_get_nickname_color(user)
{
	var v = user.color;
	if (string_length(v) == 0)
	{
		return -1;
	}
	
	return src_color_utils_hex_to_color(v);
}

/// @description Get nickname background color of user or -1
/// @param {Struct} user User
///	@return {Real}
function axelchat_user_get_nickname_background_color(user)
{
	var v = user.customBackgroundColor;
	if (string_length(v) == 0)
	{
		return -1;
	}
	
	return src_color_utils_hex_to_color(v);
}

/// @description Get contents as text of message
/// @param {Struct} message Message
/// @param {String} image_replacement Text that will be instead of the image
/// @param {Bool} html_print_as_text Need to print the HTML code as text
/// @param {String} html_replacement Text that will be instead of the HTML in case the printing of the HTML code as text is disabled
///	@return {String}
function axelchat_message_get_contents_as_text(message, image_replacement = "[IMAGE]", html_print_as_text = true, html_replacement = "[HTML]")
{
	var result = "";
	
	for (var i = 0; i < array_length(message.contents); i++)
	{
		var content = message.contents[i];
		var type = string_upper(content.type);
		if (type == "TEXT")
		{
			result += content.data.text;
		}
		else if (type == "HYPERLINK")
		{
			result += content.data.text;
		}
		else if (type == "HTML")
		{
			if (html_print_as_text)
			{
				result += content.data.html;
			}
			else
			{
				result += html_replacement;
			}
		}
		else if (type == "IMAGE")
		{
			result += image_replacement;
		}
		else
		{
			show_debug_message("Unknown content type \"" + type + "\"");
		}
	}
	
	return result;
}

/// @description Get message id
/// @param {Struct} message Message
///	@return {String}
function axelchat_message_get_id(message)
{
	return message.id;
}

/// @description Get badges of user as array of URLs
/// @param {Struct} user User
///	@return {Array[String]}
function axelchat_user_get_badges(user)
{
	var result = [];
	
	for (var i = 0; i < array_length(user.leftBadges); i++)
	{
		var badge = user.leftBadges[i];
		array_push(result, badge);
	}
	
	for (var i = 0; i < array_length(user.rightBadges); i++)
	{
		var badge = user.rightBadges[i];
		array_push(result, badge);
	}
	
	return result;
}

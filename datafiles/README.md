# AxelChatClientGM
GameMaker client for communication with AxelChat via WebSocket

## How to use

### Connect to AxelChat

1. Copy this group (aka folder) with all its contents to your project
2. Place o_axelchat_client to room
3. In o_axelchat_client open Variable Definitions and set:
	server_address - The address of the server where AxelChat is running. If AxelChat is running on the same device as the GameMaker-project, then enter 127.0.0.1. Otherwise, you can find the address in the AxelChat settings
    server_port - AxelChat server port. Usually it is 8356. You can get it in the settings of AxelChat
	on_connected_script - Script that will be called upon successful connection to AxelChat
    on_state_changed - Script that will be called when the state of AxelChat changes. For example, when the number of viewers changes
    on_message_received_script - Script that will be called when a message is received

### Disconnect from AxelChat

1. Just destroy instance of o_axelchat_client
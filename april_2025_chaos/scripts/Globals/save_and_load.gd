extends Node


var file_saved : bool 

# Creating a new config file to be written to 
var config = ConfigFile.new()

func _ready() -> void:
	load_data()
# creating a cidtionary in the config file, key ( catagory) with the value (name of the data being saved) and stores the data under that value.
func save():
	# Audio settings
	config.set_value("audio_settings", "master_muted", AudioManager.master_muted)
	config.set_value("audio_settings", "music_muted", AudioManager.music_muted)
	config.set_value("audio_settings", "sfx_muted", AudioManager.sfx_muted)
	config.set_value("audio_settings", "master_volume", AudioManager.master_volume)
	config.set_value("audio_settings", "music_volume", AudioManager.music_volume)
	config.set_value("audio_settings", "sfx_volume", AudioManager.sfx_volume)
	# progression
	config.set_value("progression", "current_highest_level", GameManager.current_highest_level)
	
	
	config.save("user://savegame.cfg")

# retrieves the updated config, checks if the retrieval was succesful, then checks for the key (catagory) is present 
# sets the value to the saved data stored in the config 
func load_data():
	var recovered_data = config.load("user://savegame.cfg")
	if recovered_data == OK:
		file_saved = true
		if config.has_section("audio_settings"):
			print("has audio settings")
			AudioManager.master_muted = config.get_value("audio_settings", "master_muted")
			AudioManager.music_muted = config.get_value("audio_settings", "music_muted")
			AudioManager.sfx_muted = config.get_value("audio_settings", "sfx_muted")
			AudioManager.master_volume = config.get_value("audio_settings", "master_volume")
			AudioManager.music_volume = config.get_value("audio_settings", "music_volume")
			AudioManager.sfx_volume = config.get_value("audio_settings", "sfx_volume")
		if config.has_section("progression"):
			GameManager.current_highest_level = config.get_value("progression", "current_highest_level")
		

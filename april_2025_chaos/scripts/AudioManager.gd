extends Node

var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("SFX")

var master_volume : int = 0
var music_volume : int = 0
var sfx_volume : int = 0
var master_muted : bool
var sfx_muted : bool
var music_muted : bool

func _ready() -> void:
	set_bus_volume(0,master_volume)
	set_bus_volume(1,music_volume)
	set_bus_volume(2,sfx_volume)

func set_bus_volume(value, index):
	AudioServer.set_bus_volume_db(index, value)
	if value == -30:
		AudioServer.set_bus_mute(index, true)
	else:
		AudioServer.set_bus_mute(index, false)

func toggle_mute(index, status):
	AudioServer.set_bus_mute(index, status)
	

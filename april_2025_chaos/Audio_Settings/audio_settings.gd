extends Node

var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("SFX")
@onready var master_anim = $settings/master_anim
@onready var music_anim = $settings/music_anim
@onready var sfx_anim = $settings/sfx_anim

func _process(delta: float) -> void:
	print(AudioServer.get_bus_volume_db(0))
	print(AudioServer.get_bus_volume_db(1))
	print(AudioServer.get_bus_volume_db(2))

func _on_master_volume_slider_value_changed(value: float) -> void:
		AudioServer.set_bus_volume_db(master_bus, value)
		if value == -30:
			AudioServer.set_bus_mute(master_bus, true)
			master_anim.play("mute")
		else:
			AudioServer.set_bus_mute(master_bus, false)
			master_anim.play("unmute")

func _on_music_volume_slider_value_changed(value: float) -> void:
		AudioServer.set_bus_volume_db(music_bus, value)
		if value == -30:
			AudioServer.set_bus_mute(music_bus, true)
			music_anim.play("mute")
		else:
			AudioServer.set_bus_mute(music_bus, false)
			music_anim.play("unmute")

func _on_sfx_volume_slider_value_changed(value: float) -> void:
		AudioServer.set_bus_volume_db(sfx_bus, value)
		if value == -30:
			AudioServer.set_bus_mute(sfx_bus, true)
			sfx_anim.play("mute")
		else:
			AudioServer.set_bus_mute(sfx_bus, false)
			sfx_anim.play("unmute")

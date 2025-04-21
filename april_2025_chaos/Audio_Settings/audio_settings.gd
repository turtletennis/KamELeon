extends Node2D

@onready var master_anim = $settings/master_anim
@onready var music_anim = $settings/music_anim
@onready var sfx_anim = $settings/sfx_anim
@onready var master_volume_slider: HSlider = $settings/master_volume_slider
@onready var music_volume_slider: HSlider = $settings/music_volume_slider
@onready var sfx_volume_slider: HSlider = $settings/sfx_volume_slider
var master_muted : bool
var music_muted : bool
var sfx_muted : bool

func _ready() -> void:
	master_volume_slider.value = AudioManager.master_volume
	music_volume_slider.value = AudioManager.music_volume
	sfx_volume_slider.value = AudioManager.sfx_volume
	master_muted = AudioManager.master_muted
	music_muted = AudioManager.music_muted
	sfx_muted = AudioManager.sfx_muted

func _process(delta: float) -> void:
	mute_anim()

func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioManager.set_bus_volume(value, 0)
	AudioManager.master_volume = value
	if value == -30:
			master_muted = true
	else:
			master_muted = false

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioManager.set_bus_volume(value, 1)
	AudioManager.music_volume = value
	if value == -30:
			music_muted = true
	else:
			master_muted = false

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioManager.set_bus_volume(value, 2)
	AudioManager.sfx_volume = value
	if value == -30:
			sfx_muted = true
	else:
			sfx_muted = false



func _on_master_mute_button_pressed() -> void:
	master_muted = !master_muted
	AudioManager.toggle_mute(0,master_muted)
	AudioManager.master_muted = !AudioManager.master_muted

func _on_music_mute_button_pressed() -> void:
	music_muted = !music_muted
	AudioManager.toggle_mute(1, music_muted)
	AudioManager.music_muted = !AudioManager.music_muted


func _on_sfx_mute_button_pressed() -> void:
	sfx_muted = !sfx_muted
	AudioManager.toggle_mute(2, sfx_muted)
	AudioManager.sfx_muted = !AudioManager.sfx_muted


func mute_anim():
	if sfx_muted:
		sfx_anim.play("mute")
	else:
		sfx_anim.play("unmute")
	if master_muted:
		master_anim.play("mute")
	else:
		master_anim.play("unmute")
	if music_muted:
		music_anim.play("mute")
	else:
		music_anim.play("unmute")

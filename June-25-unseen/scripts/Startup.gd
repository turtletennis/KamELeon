extends Node

var _started: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FictionalOptionsManager.AddConfigSection("Audio", AudioOptions.new())
	FictionalOptionsManager.LoadConfiguration()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_tree().change_scene_to_file("res://scenes/UI/MainMenu.tscn")

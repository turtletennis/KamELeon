extends OptionsManager

func _init() -> void:
	super._init()
	add_config_section("Audio", AudioOptions.new())

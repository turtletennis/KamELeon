class_name OptionsManager extends Node

var config_to_load : String
@onready var _config := ConfigFile.new()

var _config_sets :Dictionary[String, OptionsSection] = {}
func _init() -> void:
	config_to_load = "test"
	config_to_load = ProjectSettings.get_setting(OptionsManagerConsts.config_file_path_settings_prop_path, OptionsManagerConsts.config_file_path_default)
	 
func _ready():
	load_configuration()

func add_config_section(sectionName: String, type: OptionsSection) -> void:
	_config_sets[sectionName] = type

func get_config_section(section_name: String) -> OptionsSection:
	return _config_sets.get(section_name)

func load_configuration() -> void:
	_config.load(config_to_load)

	for cset: OptionsSection in _config_sets.values():
		if _config.has_section(cset.section_name):
			cset.load_config(_config)
		
	
	
func save_configuration() -> void:
	for cset: OptionsSection in _config_sets.values():
		cset.save(_config)
	
	_config.save(config_to_load)
		
func bind_notifcation(sectionName: String, callback: Callable) -> void:
	var found :OptionsSection = _config_sets.get(sectionName)
	if found != null:
		found.bind_notification(callback)

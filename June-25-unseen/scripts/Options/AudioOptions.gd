class_name AudioOptions extends OptionsSection

var MasterVolume: float = 100.0:
	get: return MasterVolume
	set(value):
		MasterVolume = value
		NotifyChange()
var MusicVolume: float = 100.0:
	get: return MusicVolume
	set(value):
		MusicVolume = value
		NotifyChange()
var EffectVolume: float = 100.0:
	get: return EffectVolume
	set(value):
		EffectVolume = value
		NotifyChange()

var MasterMuted: bool = false:
	get: return MasterMuted
	set(value):
		MasterMuted = value
		NotifyChange()
		
var MusicMuted: bool = false:
	get: return MusicMuted
	set(value):
		MusicMuted = value
		NotifyChange()
var EffectMuted: bool = false:
	get: return EffectMuted
	set(value):
		EffectMuted = value
		NotifyChange()

func _init() -> void:
	super._init("Audio")
	configKeyMap["MasterVolume"] = &"MasterVolume"
	configKeyMap["MusicVolume"] = &"MusicVolume"
	configKeyMap["EffectVolume"] = &"EffectVolume"
	configKeyMap["MasterMuted"] = &"MasterMuted"
	configKeyMap["MusicMuted"] = &"MusicMuted"
	configKeyMap["EffectMuted"] = &"EffectMuted"

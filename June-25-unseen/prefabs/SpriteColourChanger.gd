extends Node2D
class_name SpriteColourChanger

@export_range(-1,1) var red_hue:float = 0.6666666

@export_range(-1,1) var green_hue:float = 0

@export_range(-1,1) var blue_hue:float = 0.333333
@export_range(0,2) var normal_saturation_mult = 0.75

var hue_parameter = "hue_shift"
var sat_parameter = "saturation_mult"
var shaderMat:ShaderMaterial

func _ready() -> void:
    shaderMat = material as ShaderMaterial

func setColour(desiredColour : ChameleonColour.Colour):
    var hue = 0
    var sat = 1
    if(desiredColour == ChameleonColour.Colour.RED):
        hue = red_hue
    elif(desiredColour == ChameleonColour.Colour.BLUE):
        hue = blue_hue
    elif(desiredColour == ChameleonColour.Colour.NORMAL):
        sat = normal_saturation_mult
    shaderMat.set_shader_parameter(hue_parameter,hue)
    shaderMat.set_shader_parameter(sat_parameter,sat)
    
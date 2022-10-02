extends "res://scenes/objects/object_template.gd"


# Declare member variables here. Examples:
# var a = 2
onready var tween = $Tween
var day_texture = preload("res://assets/Art/D-Final/Assets/Hourglass_blue.png")
var night_texture = preload("res://assets/Art/D-Final/Assets/Hourglass_green.png")
var is_blue = false
# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	Globals.connect("is_night", self, "is_night")
	is_night(Globals.is_night)

func is_night(value):
	is_blue = value
	if value:
		sprite.texture = night_texture
	else:
		sprite.texture = day_texture

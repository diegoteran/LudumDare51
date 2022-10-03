extends "res://scenes/objects/object_template.gd"


var day_texture = preload("res://assets/Art/A-Final/Assets/Window_day.png")
var night_texture = preload("res://assets/Art/A-Final/Assets/Window_night.png")

# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	Globals.connect("is_night", self, "is_night")
	is_night(Globals.is_night)

func is_night(value):
	if value:
		sprite.texture = night_texture
	else: 
		sprite.texture = day_texture

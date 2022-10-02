extends "res://scenes/objects/object_template.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bg = $Sprite2
onready var tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("is_night", self, "is_night")
	is_night(Globals.is_night)

func is_night(value):
	if value:
		tween.interpolate_property(bg, "modulate", Color.wheat, Color.darkblue, 2)
	else: 
		tween.interpolate_property(bg, "modulate", Color.darkblue, Color.wheat, 2)
	tween.start()

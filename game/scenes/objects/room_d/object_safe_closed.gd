extends "res://scenes/objects/object_template.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var g1 = $g1
onready var b2 = $b2
onready var g3 = $g3

const PATTERN = ["g", "b", "g"]
var current_pattern = []
var sprites
# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	get_parent().get_node("Hourglass").connect("is_blue", self, "hourglass_clicked")
	sprites = [g1, b2, g3]

func hourglass_clicked(is_blue):
	var new_letter = "b" if is_blue else "g"
	if current_pattern.size() < 3 and new_letter == PATTERN[current_pattern.size()]:
		sprites[current_pattern.size()].visible = true
		SoundFx.play_menu("menu_move")
		current_pattern.append(new_letter)
		if current_pattern == PATTERN:
			get_parent().safe_opened()
	else:
		SoundFx.play_menu("fail", 0.8, 0)
		current_pattern = []
		sprites[0].visible = false
		sprites[1].visible = false

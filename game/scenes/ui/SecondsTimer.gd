extends Control

onready var label = $Label
# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	Globals.connect("seconds_left", self, "update_seconds_left")

func update_seconds_left(seconds_left):
	label.text = str(seconds_left)

extends Control

onready var label = $Label
func _ready():
# warning-ignore:return_value_discarded
	Globals.connect("seconds_left", self, "update_seconds_left")

func update_seconds_left(seconds_left):
	label.text = str(seconds_left)
	
	if seconds_left <= 3:
		modulate = Color.red
		SoundFx.play_menu("tock")
	else:
		modulate = Color.white

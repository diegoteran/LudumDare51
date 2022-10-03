extends "res://scenes/objects/object_template.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func object_clicked():
	Globals.is_egg_down = true
	JournalManager.add_info("D4b")
	JournalManager.add_info("D5")
	SoundFx.play_menu("egg")
	queue_free()

extends "res://scenes/rooms/room_template.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	JournalManager.add_info("C1")
	pass # Replace with function body.

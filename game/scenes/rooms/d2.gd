extends "res://scenes/rooms/room_template.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var egg = $Egg
onready var safe_closed = $SafeClosed

# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.is_egg_down:
		egg.queue_free()
	
	if Globals.is_safe_open:
		safe_closed.queue_free()


func safe_opened():
	Globals.safe_open = true

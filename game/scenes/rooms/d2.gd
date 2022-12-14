extends "res://scenes/rooms/room_template.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var egg = $Egg
onready var safe_closed = $SafeClosed
onready var safe_open = $SafeOpen
onready var journal = $Journal

# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.is_egg_down:
		egg.queue_free()
	
	if Globals.is_safe_open:
		safe_closed.queue_free()
		safe_open.visible = true
		journal.visible = true


func safe_opened():
	Globals.is_safe_open = true
	safe_closed.queue_free()
	safe_open.visible = true
	journal.visible = true
	JournalManager.add_info("D5b")

extends "res://scenes/rooms/room_template.gd"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if state == CURRENT:
		Globals.office_visited = true

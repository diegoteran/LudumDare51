extends "res://scenes/objects/room_a/wall_lever.gd"

func _ready():
	Globals.connect("lever_freed", self, "add_lever_to_ui")
	visible = false;
	start_pos = 300;
	frame_starts = [0,300,500,800,1000]

func add_lever_to_ui():
	visible = true;

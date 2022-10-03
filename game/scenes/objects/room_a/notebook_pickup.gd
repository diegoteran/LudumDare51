extends "res://scenes/objects/object_template.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = !Globals.has_notebook
	pass # Replace with function body.


func object_clicked():
	Globals.notebook_acquired();
	Globals.paused = true;
	Globals._get_gameplay().start_dialog("hints")
	queue_free();
	pass

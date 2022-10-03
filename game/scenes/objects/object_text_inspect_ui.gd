extends "res://scenes/objects/object_text_inspect.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = Globals.has_notebook;
# warning-ignore:return_value_discarded
	Globals.connect("get_notebook", self, "add_notebook")
	Globals.connect("remove_notebook", self, "remove_notebook")
	JournalManager.connect("new_info", self, "shake_anim");
	pass # Replace with function body.

func shake_anim():
	if Globals.has_notebook:
		SoundFx.play_menu("journal")
	$AnimationPlayer.play("Shake")

func add_notebook():
	visible = true;
	
func remove_notebook():
	visible = false;

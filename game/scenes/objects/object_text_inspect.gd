extends "res://scenes/objects/object_template.gd"



export var TEXT_OVERLAY: PackedScene;

func object_clicked():
	print("text inspect clicked");
	var text = TEXT_OVERLAY.instance();
	get_parent().add_child(text);
	pass

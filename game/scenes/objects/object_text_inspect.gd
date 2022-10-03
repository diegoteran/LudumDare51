extends "res://scenes/objects/object_template.gd"



export var TEXT_OVERLAY: PackedScene;

func object_clicked():
	if Globals.paused:
		return;
	print("text inspect clicked");
	var text = TEXT_OVERLAY.instance();
	Globals._get_gameplay().get_node("RoomManager").add_child(text);
	Globals.paused = true;
	pass

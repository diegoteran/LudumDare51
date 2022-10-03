extends "res://scenes/objects/object_template.gd"



export var PATTERN: PackedScene;

func object_clicked():
	if Globals.paused:
		return;
	print("text inspect clicked");
	var pat = PATTERN.instance();
	Globals._get_gameplay().get_node("RoomManager").add_child(pat);
	pass

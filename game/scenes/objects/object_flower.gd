extends "res://scenes/objects/object_template.gd"


var click_counter = 0

signal key_dropped

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func object_clicked():
	print("I AM FLOWER")
	click_counter += 1
	
	if click_counter == 3:
		emit_signal("key_dropped")

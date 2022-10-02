extends "res://scenes/objects/object_template.gd"


var click_counter = 0
var hold_time = 0

signal key_dropped

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	if !mouse_in_object:
		hold_time = OS.get_ticks_msec()
		return
	
	if Input.is_action_just_released("click") and mouse_in_object:
		hold_time = OS.get_ticks_msec() - hold_time
		print(hold_time)
		if hold_time > 3000:
			print("Start animation")
		
		hold_time = 0
	
	if Input.is_action_just_pressed("click") and mouse_in_object:
		hold_time = OS.get_ticks_msec()


func object_clicked():
	print("I AM FLOWER")
	click_counter += 1
	
	if click_counter == 3:
		emit_signal("key_dropped")

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
	
	if OS.get_ticks_msec() - hold_time > 4000:
			get_parent().start_anim()
	
	if Input.is_action_just_released("click") and mouse_in_object:
		hold_time = OS.get_ticks_msec() - hold_time
		print("hold_time  " + hold_time)
		hold_time = 0
	
	if Input.is_action_just_pressed("click") and mouse_in_object:
		hold_time = OS.get_ticks_msec()


func object_clicked():
	click_counter += 1
	SoundFx.play_menu("shake", rand_range(0.9, 1.1))
	
	if click_counter == 3:
		emit_signal("key_dropped")

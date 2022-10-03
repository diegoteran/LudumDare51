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
	
	if Input.is_action_just_released("click"):
		hold_time = OS.get_ticks_msec()
	
	if Input.is_action_just_pressed("click") and mouse_in_object:
		hold_time = OS.get_ticks_msec()
	
	if OS.get_ticks_msec() - hold_time > 3000:
			get_parent().start_anim()
			JournalManager.add_info("A3")


func object_clicked():
	click_counter += 1
	SoundFx.play_menu("shake", rand_range(0.9, 1.1))
	$AnimationPlayer.play("shake")
	
	if click_counter == 3:
		emit_signal("key_dropped")
		JournalManager.add_info("A2")

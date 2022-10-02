extends Node

var unlocked_rooms = {"a1": [], "a2": [], "a3": [], "h1": [], "h2": [],
					  "b1": [], "b2": [], "b3": [], "c1": [], "c2": [], "c3": [],
					  "d1": [], "d2": [], "d3": []}

var seconds_left_to_cleanse = 0
var office_locked = false
var office_visited = false
var rooms_unlocked = false

var paused = true;

var one_fuckup_left = true;

var successful_presses = 0;

var operator_num = 34634643;

const SHIFT_AMOUNT = 15;

signal seconds_left(seconds_left)
signal rooms_unlocked
signal door_timer

onready var world_timer = $WorldTimer
onready var second_timer = $SecondTimer
onready var door_timer = $DoorTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	seconds_left_to_cleanse = 10
	emit_signal("seconds_left",  10)
	
	second_timer.wait_time = 1.5
	world_timer.wait_time = 60 * 2.0
	door_timer.wait_time = 45

func unlock_all_rooms():
	rooms_unlocked = true
	emit_signal("rooms_unlocked")

func start_world_timer():
	world_timer.start()
	door_timer.start()
	
func start_second_timer():
	print("HUMANS CLEANSED")
	second_timer.start()
	seconds_left_to_cleanse = 10
	successful_presses += 1;
	
	if successful_presses > 3:
		one_fuckup_left = false;
		print("OKAY TUTORIAL OVER");
	
	emit_signal("seconds_left",  10)


func unpause():
	paused = false;

func restart():
	return;
	#UNDO DEBUG
	Game.restart_scene();

func _on_WorldTimer_timeout():
	paused = true;
	_get_gameplay().start_dialog("ShiftEnd")

func _get_gameplay():
	return get_tree().get_root().get_node("/root/Gameplay");

func _on_SecondTimer_timeout():
	if (paused):
		return;
	seconds_left_to_cleanse -= 1
	emit_signal("seconds_left",  seconds_left_to_cleanse)
	
	if seconds_left_to_cleanse == 0:
		if one_fuckup_left:
			one_fuckup_left = false;
			paused = true;
			start_second_timer();
			_get_gameplay().start_dialog("help")
		else:
			paused = true;
			_get_gameplay().start_dialog("termination")
		print("TEN SECONDS PASSED")

func _on_DoorTimer_timeout():
	office_locked = !office_visited
	emit_signal("door_timer")
	if office_locked:
		SoundFx.play_menu("close_door")

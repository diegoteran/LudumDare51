extends Node

# Reset
var unlocked_rooms = {"a1": [], "a2": [], "a3": [], "h1": [], "h2": [],
					  "b1": [], "b2": [], "b3": [], "c1": [], "c2": [], "c3": [],
					  "d1": [], "d2": [], "d3": []}
var seconds_left_to_cleanse = 0
var office_locked = false
var office_visited = false
var rooms_unlocked = false
var one_fuckup_left = true;
var successful_presses = 0;
var operator_num = 23;
var on_last_screen = false
var is_night = false
var is_safe_open = false
var is_egg_down = false
var current_room = "a3"
var has_notebook = false
var has_lever = false;
var is_flower_up = false
var key_seen_atleast_once = false
var doors_opened_atleast_once = false
var final_timer_ended = false;
var final_timer_started = false

var paused = true;

const SHIFT_AMOUNT = 15;

signal seconds_left(seconds_left)
signal rooms_unlocked
signal door_timer
signal is_night(value)
signal lever_freed;
signal get_notebook;
signal lever
signal bell(note)
signal remove_notebook;
signal complete_game;

onready var world_timer = $WorldTimer
onready var second_timer = $SecondTimer
onready var door_timer = $DoorTimer
onready var final_timer = $FinalRoomTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	seconds_left_to_cleanse = 10
	emit_signal("seconds_left",  10)
	
	second_timer.wait_time = 2
	world_timer.wait_time = 60 * 2.0
	door_timer.wait_time = 45
	final_timer.wait_time = 15

func unlock_all_rooms():
	SoundFx.play_menu("unlock_door")
	rooms_unlocked = true
	emit_signal("rooms_unlocked")
	if not doors_opened_atleast_once:
		_get_gameplay().start_dialog("door_opens")
		doors_opened_atleast_once = true;

func start_world_timer():
#	world_timer.start()
	door_timer.start()

func bell_note(note):
	emit_signal("bell", note)
	
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

func pause():
	paused = true;
	
func restart():
	reset()
	Game.restart_scene();

func lever_freed():
	print("Lever off wall")
	emit_signal("lever_freed")
	has_lever = true;
	JournalManager.add_info("L4")

func notebook_acquired():
	has_notebook = true;
	emit_signal("get_notebook")

func remove_notebook():
	emit_signal("remove_notebook")

func _on_WorldTimer_timeout():
	return;
	paused = true;
	_get_gameplay().start_dialog("ShiftEnd")

func _get_gameplay():
	return get_tree().get_root().get_node("/root/Gameplay");

func lever_pulled():
	emit_signal("lever")
	start_second_timer()

func reset():
	unlocked_rooms = {"a1": [], "a2": [], "a3": [], "h1": [], "h2": [],
					  "b1": [], "b2": [], "b3": [], "c1": [], "c2": [], "c3": [],
					  "d1": [], "d2": [], "d3": []}
	seconds_left_to_cleanse = 0
	office_locked = false
	office_visited = false
	rooms_unlocked = false
	successful_presses = 0
	operator_num += 1
	on_last_screen = false
	is_night = false
	is_safe_open = false
	is_egg_down = false
	has_lever = false
	current_room = "a3"
	is_flower_up = false
	key_seen_atleast_once = false
	doors_opened_atleast_once = false
	final_timer_ended = false;
	final_timer_started = false;

func _on_SecondTimer_timeout():
	if (paused):
		return;
	seconds_left_to_cleanse -= 1
	emit_signal("seconds_left",  seconds_left_to_cleanse)
	
	if seconds_left_to_cleanse == 0:
		if one_fuckup_left and !on_last_screen:
			one_fuckup_left = false;
			paused = true;
			start_second_timer();
			_get_gameplay().start_dialog("help")
		else:
			paused = true;
			if !on_last_screen:
				_get_gameplay().start_dialog("termination")
		print("TEN SECONDS PASSED")

func _on_DoorTimer_timeout():
	if rooms_unlocked:
		return
	office_locked = !office_visited
	emit_signal("door_timer")
	if office_locked:
		SoundFx.play_menu("close_door")

func teleport_input():
	on_last_screen = true
	current_room = "z"
	disable_all_timers()
	set_ui()
	_get_gameplay().to_z()

func disable_all_timers():
	world_timer.stop()
	door_timer.stop()

func set_ui():
	# Maybe remove lever
	pass

func change_time():
	SoundFx.play_menu("tick")
	is_night = !is_night
	emit_signal("is_night", is_night)

func start_final_timer():
	print("start timer")
	if final_timer_ended:
		_on_FinalRoomTimer_timeout()
	elif not final_timer_started:
		final_timer.start();
	final_timer_started = true;

func add_exit():
	Game.change_scene("res://scenes/menu/menu.tscn", {
		'show_progress_bar': false
	})
	SoundFx.play_menu("thunder", rand_range(0.8, 1.2), 0)
	pass;

func _on_FinalRoomTimer_timeout():
	print("timeout")
	final_timer_ended = true;
	if paused:
		return
	reset()
	Globals._get_gameplay().start_dialog("ShiftEnd")

extends Node

var unlocked_rooms = {"a1": [], "a2": [], "a3": [], "h1": [], "h2": [],
					  "b1": [], "b2": [], "b3": [], "c1": [], "c2": [], "c3": [],
					  "d1": [], "d2": [], "d3": []}

var seconds_left_to_cleanse = 0

signal seconds_left(seconds_left)

onready var world_timer = $WorldTimer
onready var second_timer = $SecondTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	seconds_left_to_cleanse = 10
	emit_signal("seconds_left",  10)
	
	second_timer.wait_time = 1.5
	world_timer.wait_time = 60 * 5.0


func start_world_timer():
	world_timer.start()
	
func start_second_timer():
	print("HUMANS CLEANSED")
	second_timer.start()
	seconds_left_to_cleanse = 10
	emit_signal("seconds_left",  10)

func _on_WorldTimer_timeout():
	print("WORLD TIMEOUTT")


func _on_SecondTimer_timeout():
	seconds_left_to_cleanse -= 1
	emit_signal("seconds_left",  seconds_left_to_cleanse)
	
	if seconds_left_to_cleanse == 0:
		print("TEN SECONDS PASSED")

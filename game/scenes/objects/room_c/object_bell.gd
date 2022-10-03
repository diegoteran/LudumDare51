extends "res://scenes/objects/object_template.gd"

const CELESTIAL_PATTERN = ["right", "down", "up", "left", "down"]

onready var timer = $Timer

var note = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = 1.3

func object_clicked():
	timer.stop()
	note = 0
	_on_Timer_timeout()
	JournalManager.add_info("C2")
	JournalManager.add_info("C3")

func _on_Timer_timeout():
	SoundFx.play_menu(CELESTIAL_PATTERN[note])
	note += 1
	if note < 5:
		timer.start()

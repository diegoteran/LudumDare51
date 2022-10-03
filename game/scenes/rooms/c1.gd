extends "res://scenes/rooms/room_template.gd"

onready var bell = $Bell
onready var P = preload("res://scenes/objects/burst.tscn")

var colors = {"right": Color.blue, "down": Color.red, "left": Color.green, "up": Color.purple}

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("bell", self, "note_played")


func note_played(note):
	var instance = P.instance()
	instance.color = colors[note]
	add_child(instance)
	instance.global_position = Game.size / 2

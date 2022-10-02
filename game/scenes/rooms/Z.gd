extends Node2D


onready var stars = $Stars
onready var earth = $Earth

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	stars.position = (Game.size / 2 - get_global_mouse_position()) * 0.08
	earth.position = (Game.size / 2 - get_global_mouse_position()) * 0.05

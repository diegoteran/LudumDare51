extends Node2D

export var THUNDER : PackedScene

onready var stars = $Stars
onready var earth = $Earth
onready var thunders = $Thunders
onready var p = $Position2D

# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	Globals.connect("lever", self, "lever")
	SoundFx.play_menu("teleport", 0.5, 0)
	SoundFx.play_menu("space", 1, 0)


func _process(_delta):
	stars.position = (Game.size / 2 - get_global_mouse_position()) * 0.08
	earth.position = (Game.size / 2 - get_global_mouse_position()) * 0.05
	thunders.position = (Game.size / 2 - get_global_mouse_position()) * 0.03


func lever():
	SoundFx.play_menu("thunder", rand_range(0.8, 1.2), 0)
	spawn_thunder()

func spawn_thunder():
	var instance = THUNDER.instance()
	thunders.add_child(instance)
	instance.position = p.position + Vector2(rand_range(-0.5, 0.5) * 1000, 0)

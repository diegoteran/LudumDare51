extends "res://scenes/rooms/room_template.gd"

onready var flower = $Flower
#
#class FlowerClass:
	
# Called when the node enters the scene tree for the first time.
func _ready():
	flower.connect("key_dropped", self, "on_key_dropped")

func on_key_dropped():
	SoundFx.play_menu("unlock_door")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

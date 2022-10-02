extends "res://scenes/objects/object_template.gd"

var open_door = preload("res://assets/Art/A-Final/Assets/Door_open.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.rooms_unlocked or Globals.unlocked_rooms["a1"].has("LEFT"):
		sprite.texture = open_door

func open_door():
	sprite.texture = open_door

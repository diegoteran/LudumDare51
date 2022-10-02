extends "res://scenes/objects/object_template.gd"

var open_door_texture = preload("res://assets/Art/A-Final/Assets/Door_open.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.scale *= Vector2(-1, 1)
	if Globals.rooms_unlocked or Globals.unlocked_rooms["h1"].has("RIGHT"):
		sprite.texture = open_door_texture

func open_door():
	sprite.texture = open_door_texture

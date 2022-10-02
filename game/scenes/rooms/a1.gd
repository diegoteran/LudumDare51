extends "res://scenes/rooms/room_template.gd"

onready var flower = $Flower
onready var animationPlayer = $AnimationPlayer
onready var door_left = $DoorLeft
	
# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	Globals.connect("rooms_unlocked", self, "unlock_left")
	flower.connect("key_dropped", self, "on_key_dropped")

func on_key_dropped():
	if(locked_rooms.has("LEFT")):
		SoundFx.play_menu("key_falls")
	
		# Take key or dialog
		yield(get_tree().create_timer(1), "timeout")
		unlock_left()
		

func unlock_left():
	if(locked_rooms.has("LEFT")):
		SoundFx.play_menu("unlock_door")
		unlock_room("LEFT")
		
		door_left.open_door()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

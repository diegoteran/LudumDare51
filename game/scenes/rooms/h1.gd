extends "res://scenes/rooms/room_template.gd"


func _ready():
	Globals.connect("rooms_unlocked", self, "unlock")
	if Globals.office_locked:
		pass

func unlock():
	unlock_left()
	unlock_right()

func unlock_left():
	if(locked_rooms.has("LEFT")):
		SoundFx.play_menu("unlock_door")
		unlock_room("LEFT")

func unlock_right():
	if(locked_rooms.has("RIGHT")):
		SoundFx.play_menu("unlock_door")
		unlock_room("RIGHT")
	

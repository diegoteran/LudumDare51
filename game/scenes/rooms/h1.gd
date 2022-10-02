extends "res://scenes/rooms/room_template.gd"

onready var door_office = $DoorOffice
onready var door_bell = $DoorBell

func _ready():
# warning-ignore:return_value_discarded
	Globals.connect("rooms_unlocked", self, "unlock")
# warning-ignore:return_value_discarded
	Globals.connect("door_timer", self, "door_timeout")
	if Globals.office_locked:
		locked_rooms.append("LEFT")

func unlock():
	unlock_left()
	unlock_right()

func unlock_left():
	if(locked_rooms.has("LEFT")):
		SoundFx.play_menu("unlock_door")
		unlock_room("LEFT")
		door_office.open_door()

func unlock_right():
	if(locked_rooms.has("RIGHT")):
		SoundFx.play_menu("unlock_door")
		unlock_room("RIGHT")
		door_bell.open_door()

func door_timeout():
	if !Globals.office_visited:
		door_office.close_door()
		locked_rooms.append("LEFT")

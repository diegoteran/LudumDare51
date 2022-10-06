extends "res://scenes/rooms/room_template.gd"

onready var door_office_open = $DoorOfficeOpen
onready var door_office_closed = $DoorOfficeClosed
onready var door_bell_open = $DoorBellOpen
onready var door_bell_closed = $DoorBellClosed


func _ready():
# warning-ignore:return_value_discarded
	Globals.connect("rooms_unlocked", self, "unlock")
# warning-ignore:return_value_discarded
	Globals.connect("door_timer", self, "door_timeout")
	if Globals.office_locked:
		locked_rooms.append("LEFT")
		
	# bell door
	if Globals.rooms_unlocked or Globals.unlocked_rooms["h1"].has("RIGHT"):
		if !Globals.unlocked_rooms["h1"].has("RIGHT"):
			Globals.unlocked_rooms["h1"].append("RIGHT")
		open_door_bell()
	
	# office door
	if Globals.rooms_unlocked or !Globals.office_locked:
		open_door_office()
	else:
		close_door_office()

func unlock():
	unlock_left()
	unlock_right()

func unlock_left():
	if(locked_rooms.has("LEFT")):
		SoundFx.play_menu("unlock_door")
		unlock_room("LEFT")
		open_door_office()

func unlock_right():
	if(locked_rooms.has("RIGHT")):
		SoundFx.play_menu("unlock_door")
		unlock_room("RIGHT")
		open_door_bell()

func door_timeout():
	if !Globals.office_visited and !Globals.rooms_unlocked:
		close_door_office()
		locked_rooms.append("LEFT")

func open_door_office():
	door_office_open.visible = true
	door_office_closed.visible = false
	
func close_door_office():
	door_office_open.visible = false
	door_office_closed.visible = true

func open_door_bell():
	door_bell_open.visible = true
	door_bell_closed.visible = false

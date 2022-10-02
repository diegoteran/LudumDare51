extends Node2D

const BG_PATH_1 = "res://assets/Art/"
const BG_PATH_2 = "/Assets/Room_"
const BG_PATH_3 = ".png"

export var adjacent_room_names = {"UP" : "", "RIGHT" : "", "DOWN" : "", "LEFT" : ""}
export var locked_rooms: PoolStringArray

signal click_move(direction)

onready var area_up = $AreaUp
onready var area_right = $AreaRight
onready var area_down = $AreaDown
onready var area_left = $AreaLeft
onready var bg = $Background

enum {
	CURRENT,
	BORDER
}

var state = BORDER
var mouse_in_area = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	var path : String = filename
	$Label.text = filename
	path = path.split("/")[4]
	path = path.split(".")[0]
	name = path
	
	set_background()
	unlock_rooms()


func set_background():
	var directory = Directory.new();
	var PATH_1 = BG_PATH_1 + name[0].capitalize() +  "-Final"
	var doFileExists = directory.dir_exists(PATH_1)
	bg.texture = load(BG_PATH_1 + name[0].capitalize() + ("-Final" if doFileExists else "") + BG_PATH_2 + name + BG_PATH_3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if state == BORDER:
		return
	
	if Input.is_action_just_pressed("click") and mouse_in_area != "":
		if mouse_in_area in locked_rooms:
			SoundFx.play_menu("locked_door")
		else:
			emit_signal("click_move", mouse_in_area)

func unlock_rooms():
	for room in Globals.unlocked_rooms[name]:
		unlock_room(room)

func unlock_room(room):
	locked_rooms.remove(locked_rooms.find(room))
	save_unlocked_room(room)
	

func save_unlocked_room(room_name):
	if !(Globals.unlocked_rooms[name].has(room_name)):
		Globals.unlocked_rooms[name].append(room_name)


func _on_AreaUp_mouse_entered():
	mouse_in_area = "UP"


func _on_AreaUp_mouse_exited():
	mouse_exited()



func _on_AreaRight_mouse_entered():
	mouse_in_area = "RIGHT"


func _on_AreaRight_mouse_exited():
	mouse_exited()


func _on_AreaDown_mouse_entered():
	mouse_in_area = "DOWN"


func _on_AreaDown_mouse_exited():
	mouse_exited()


func _on_AreaLeft_mouse_entered():
	mouse_in_area = "LEFT"


func _on_AreaLeft_mouse_exited():
	mouse_exited()

func mouse_exited():
	mouse_in_area = ""

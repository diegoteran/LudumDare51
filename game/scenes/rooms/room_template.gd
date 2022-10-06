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

onready var arrow_up = load("res://assets/Art/UI/Arrow_up.png")
onready var arrow_down = load("res://assets/Art/UI/Arrow_down.png")
onready var arrow_left = load("res://assets/Art/UI/Arrow_left.png")
onready var arrow_right = load("res://assets/Art/UI/Arrow_right.png")

onready var arrow_up_2 = $up
onready var arrow_down_2 = $down
onready var arrow_left_2 = $left
onready var arrow_right_2 = $right

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
	
#	set_background()
	unlock_rooms()


#func set_background():
#	var directory = Directory.new();
#	var PATH_1 = BG_PATH_1 + name[0].capitalize() +  "-Final"
#	var doFileExists = directory.dir_exists(PATH_1)
#	bg.texture = load(BG_PATH_1 + name[0].capitalize() + ("-Final" if doFileExists else "") + BG_PATH_2 + name + BG_PATH_3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if state == BORDER:
		return
	
	Globals.current_room = name
	match name:
		("d3"):
			JournalManager.add_info("M5")
			JournalManager.add_info("D3")
			JournalManager.add_info("D2")
			JournalManager.add_info("D4")
		("b3"):
			JournalManager.add_info("B1")
		("b1"):
			JournalManager.add_info("B3")
		("c1"):
			JournalManager.add_info("C3")
		("c2"):
			JournalManager.add_info("C2")
	
	if Input.is_action_just_pressed("click") and mouse_in_area != "":
		if mouse_in_area in locked_rooms and !Globals.unlocked_rooms[name].has(mouse_in_area):
			SoundFx.play_menu("locked_door")
		else:
			emit_signal("click_move", mouse_in_area)
	
	if !Globals.paused:
		movement_arrows()
	
func movement_arrows():
	if Input.is_action_just_pressed("ui_right") and area_right.visible:
		move_arrow("RIGHT")
	
	if Input.is_action_just_pressed("ui_up") and area_up.visible:
		move_arrow("UP")
	
	if Input.is_action_just_pressed("ui_left") and area_left.visible:
		move_arrow("LEFT")
	
	if Input.is_action_just_pressed("ui_down") and area_down.visible:
		move_arrow("DOWN")
	

func move_arrow(direction):
	if direction in locked_rooms and !Globals.unlocked_rooms[name].has(direction):
		SoundFx.play_menu("locked_door")
	else:
		emit_signal("click_move", direction)


func unlock_rooms():
	for room in Globals.unlocked_rooms[name]:
		unlock_room(room)

func unlock_room(room):
	if locked_rooms.has(room):
		locked_rooms.remove(locked_rooms.find(room))
	save_unlocked_room(room)
	

func save_unlocked_room(room_name):
	if !(Globals.unlocked_rooms[name].has(room_name)):
		Globals.unlocked_rooms[name].append(room_name)


func _on_AreaUp_mouse_entered():
	mouse_in_area = "UP"
	if OS.has_feature('HTML5'):
		arrow_up_2.visible = true
	else:
		set_mouse_cursor(arrow_up)



func _on_AreaUp_mouse_exited():
	Input.set_custom_mouse_cursor(null)
	mouse_exited()


func _on_AreaRight_mouse_entered():
	mouse_in_area = "RIGHT"
	if OS.has_feature('HTML5'):
		arrow_right_2.visible = true
	else:
		set_mouse_cursor(arrow_right)


func _on_AreaRight_mouse_exited():
	Input.set_custom_mouse_cursor(null)
	mouse_exited()


func _on_AreaDown_mouse_entered():
	mouse_in_area = "DOWN"
	if OS.has_feature('HTML5'):
		arrow_down_2.visible = true
	else:
		set_mouse_cursor(arrow_down)

func _on_AreaDown_mouse_exited():
	Input.set_custom_mouse_cursor(null)
	mouse_exited()


func _on_AreaLeft_mouse_entered():
	mouse_in_area = "LEFT"
	if OS.has_feature('HTML5'):
		arrow_left_2.visible = true
	else:
		set_mouse_cursor(arrow_left)


func _on_AreaLeft_mouse_exited():
	Input.set_custom_mouse_cursor(null)
	mouse_exited()

func _hide_all_arrows():
	arrow_down_2.visible = false;
	arrow_up_2.visible = false;
	arrow_left_2.visible = false;
	arrow_right_2.visible = false;

func mouse_exited():
	mouse_in_area = ""
	_hide_all_arrows()

func set_mouse_cursor(cursor):
	Input.set_custom_mouse_cursor(cursor, 0, Vector2(41, 41))

extends Node2D

export var adjacent_room_names = {"UP" : "", "RIGHT" : "", "DOWN" : "", "LEFT" : ""}

signal click_move(direction)

onready var area_up = $AreaUp
onready var area_right = $AreaRight
onready var area_down = $AreaDown
onready var area_left = $AreaLeft

enum {
	CURRENT,
	BORDER
}

var state = BORDER
var mouse_in_area = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if state == BORDER:
		return
	
	if Input.is_action_just_pressed("click") and mouse_in_area != "":
		emit_signal("click_move", mouse_in_area)


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

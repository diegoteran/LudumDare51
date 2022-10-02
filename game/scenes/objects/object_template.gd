extends Node2D

# maybe us enum
enum {
	NONE,
	TEXT,
	ACTION
}
export var is_interactable = true
export var is_type = NONE

var mouse_in_object = false

onready var sprite = $Sprite
onready var area = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if !is_interactable:
		remove_child(area)

func _process(_delta):
	if Input.is_action_just_pressed("click") and mouse_in_object:
		object_clicked()


func _on_Area2D_mouse_entered():
	sprite.material.set_shader_param('color', Color.white)
	mouse_in_object = true


func _on_Area2D_mouse_exited():
	sprite.material.set_shader_param('color', Color.transparent)
	mouse_in_object = false

func object_clicked():
	# Dont add code here, inherit/extend this script and override in future objects.
	pass

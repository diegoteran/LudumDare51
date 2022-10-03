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


func _process(_delta):
	if Input.is_action_just_pressed("click") and mouse_in_object:
		if not Globals.paused:
			object_clicked()


func _on_Area2D_mouse_entered():
	mouse_in_object = true
	if Globals.paused:
		return;
	if is_interactable:
		sprite.material.set_shader_param('color', Color.white)

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if not event.is_pressed():  # touch released.
			_on_Area2D_mouse_exited()


func _on_Area2D_mouse_exited():
	mouse_in_object = false
	if is_interactable:
		sprite.material.set_shader_param('color', Color.transparent)


func object_clicked():
	# Dont add code here, inherit/extend this script and override in future objects.
	pass

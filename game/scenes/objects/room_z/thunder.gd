extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()


func _on_Timer_timeout():
	queue_free()

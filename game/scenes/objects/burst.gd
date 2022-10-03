extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var color

# Called when the node enters the scene tree for the first time.
func _ready():
	$Particles2D.process_material.color = color;
	$Particles2D.emitting = true;

func _on_Timer_timeout():
	queue_free()

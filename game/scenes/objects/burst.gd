extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("seconds_left", self, "test")
	pass # Replace with function body.

func test(num):
	play_particles(Color.red);

func play_particles(color):
	$Particles2D.process_material.color = color;
	$Particles2D.emitting = true;

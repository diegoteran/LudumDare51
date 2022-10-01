extends Node2D


onready var sprite = $Sprite
onready var particles = $Sprite/Particles2D
onready var tween = $Tween

var mouse_pressed = false
var current_area = ""
var current_pattern = ""

enum {
	NONE,
	LEVER,
	CIRCLE,
	HOURGLASS
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("click"):
		start_mouse()
	
	if Input.is_action_just_released("click"):
		stop_mouse()
	
	if mouse_pressed:
		sprite.position = get_global_mouse_position()
#		particles.position = get_global_mouse_position()


func start_mouse():
	mouse_pressed = true
	current_pattern = current_area
	
	tween.interpolate_property(sprite, "modulate:a", sprite.modulate.a, 100, 0.3)
	tween.start()

func stop_mouse():
	mouse_pressed = false
	
	tween.interpolate_property(sprite, "modulate:a", sprite.modulate.a, 0, 0.3)
	tween.start()
	
	var pattern = analyze_pattern()
	

func analyze_pattern():
	print("Pattern generated: " + current_pattern)
	
	if len(current_pattern) > 10:
		print("NICE TRY BITCH")
		return NONE
	
	if is_lever(current_pattern):
		print("LEVER")
		return LEVER
	
	if is_hourglass(current_pattern):
		print("HOURGLASS")
		return HOURGLASS
	
	if is_circle(current_pattern):
		print("CIRCLE")
		return CIRCLE
	
	return NONE

func is_lever(pattern):
	if len(pattern) <= 3 and pattern[0] in "AB" and pattern[-1] in "CD":
		return true
	return false

func is_hourglass(pattern):
	if len(pattern) > 6 and pattern[0] == "A" and pattern[1] == "B":
		if (pattern[2] == "C" and pattern[3] == "D") or (pattern[3] == "C" and pattern[4] == "D"):
			if pattern[4] == "A" or pattern[5] == "A" or pattern[6] == "A":
				return true
	return false
	
func is_circle(pattern):
	return "ABDCA" in pattern or "BDCAB" in pattern or "DCABD" in pattern or "CABDC" in pattern

func _on_A_mouse_entered():
	entered("A")


func _on_A_mouse_exited():
	exited("A")


func _on_B_mouse_entered():
	entered("B")


func _on_B_mouse_exited():
	exited("B")


func _on_C_mouse_entered():
	entered("C")


func _on_C_mouse_exited():
	exited("C")


func _on_D_mouse_entered():
	entered("D")


func _on_D_mouse_exited():
	exited("D")

func entered(area_name):
	current_area = area_name
	if Input.is_action_pressed("click"):
		current_pattern += area_name
	
func exited(_area_name):
	pass

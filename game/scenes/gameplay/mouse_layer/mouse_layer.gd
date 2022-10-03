extends Node2D

enum {
	NONE,
	UP,
	RIGHT,
	DOWN,
	LEFT,
	CIRCLE,
	HOURGLASS,
	FINAL
}

const TELEPORT_PATTERN = [RIGHT, DOWN, UP, LEFT, DOWN]

onready var sprite = $Sprite
onready var particles = $Particles2D
onready var tween = $Tween

var mouse_pressed = false
var current_area = ""
var current_pattern = ""
var patterns = []

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
		particles.position = get_global_mouse_position()


func start_mouse():
	mouse_pressed = true
	current_pattern = current_area
	
	particles.emitting = true
	tween.interpolate_property(sprite, "modulate:a", sprite.modulate.a, 100, 0.3)
	tween.start()

func stop_mouse():
	mouse_pressed = false
	
	tween.interpolate_property(sprite, "modulate:a", sprite.modulate.a, 0, 0.3)
	tween.start()
	
	particles.emitting = false
	
	var pattern = analyze_pattern()
	check_patterns(pattern)
	check_sound(pattern)
	if pattern == RIGHT:
		Globals.lever_pulled()

func check_sound(last_pattern):
	if last_pattern in TELEPORT_PATTERN:
		match last_pattern:
			(RIGHT):
				if Globals.on_last_screen:
					SoundFx.play_menu("right")
			(LEFT):
				if Globals.current_room == "c1":
					SoundFx.play_menu("left")
			(UP):
				if Globals.current_room == "c1":
					SoundFx.play_menu("up")
			(DOWN):
				if Globals.current_room == "c1":
					SoundFx.play_menu("down")

func check_patterns(last_pattern):
	
	
	if patterns.size() == TELEPORT_PATTERN.size():
		if patterns == TELEPORT_PATTERN:
			print("TELEPOOOOORT")
			Globals.teleport_input()
			patterns = []
		else:
			patterns = []
	
	else:
		for i in range(patterns.size()):
			if patterns[i] != TELEPORT_PATTERN[i]:
				patterns = []
				if last_pattern in TELEPORT_PATTERN:
					patterns = [last_pattern]
				return
	

func analyze_pattern():
	print("Pattern generated: " + current_pattern)
	
	if len(current_pattern) > 10 or len(current_pattern) <= 0:
		print("NICE TRY BITCH")
		return NONE
	
	if is_up(current_pattern):
		print("UP")
		return UP
	
	if is_right(current_pattern):
		print("LEVER or RIGHT")
		return RIGHT
	
	if is_down(current_pattern):
		print("DOWN")
		return DOWN
	
	if is_left(current_pattern):
		print("LEFT")
		return LEFT
	
	patterns = []
	
	if is_hourglass(current_pattern):
		print("HOURGLASS")
		Globals.unlock_all_rooms()
		return HOURGLASS
	
	if is_circle(current_pattern):
		print("CIRCLE")
		Globals.change_time()
		return CIRCLE
	
	return NONE

func is_up(pattern):
	if len(pattern) <= 3 and pattern[0] in "CD" and pattern[-1] in "AB":
		patterns.append(UP)
		return true
	return false

func is_right(pattern):
	if len(pattern) <= 3 and pattern[0] in "AC" and pattern[-1] in "BD":
		patterns.append(RIGHT)
		return true
	return false

func is_down(pattern):
	if len(pattern) <= 3 and pattern[0] in "AB" and pattern[-1] in "CD":
		patterns.append(DOWN)
		return true
	return false

func is_left(pattern):
	if len(pattern) <= 3 and pattern[0] in "BD" and pattern[-1] in "CA":
		patterns.append(LEFT)
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

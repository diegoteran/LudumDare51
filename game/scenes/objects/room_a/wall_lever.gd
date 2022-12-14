extends "res://scenes/objects/object_template.gd"


var moving_lever = false;
var start_pos = 700;
var frame_starts = [0,200,500]
var screws = [true, true, true, true]

# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.has_lever:
		get_parent().get_node("wallhatch").visible = true;
		queue_free()

func _process(_delta):
	if not (true in screws):
		SoundFx.play_menu("egg")
		Globals.lever_freed();
		get_parent().get_node("wallhatch").visible = true;
		queue_free();
	

func _on_LeverPull_mouse_entered():
	sprite.material.set_shader_param('color', Color.white)
	mouse_in_object = true


func _on_LeverPull_mouse_exited():
	sprite.material.set_shader_param('color', Color.transparent)
	mouse_in_object = false

func _on_LeverPull_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		moving_lever = true;
		print("start clicking")

func _input(event):
	if event is InputEventMouseMotion:
		if moving_lever:
			var index = -1;
			for frame_start in frame_starts:
				var mouse_pos = (event.position.x - start_pos)
				if mouse_pos > frame_start:
					index += 1;
			$AnimatedSprite.set_frame(index);
	
	if event is InputEventMouseButton && (!event.pressed and moving_lever):
		print("release")
		moving_lever = false;
		$AnimatedSprite.set_frame(0);


func _on_screw1_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		SoundFx.play_menu("screw")
		screws[0] = false;
		$screw.visible = false;


func _on_screw2_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		SoundFx.play_menu("screw")
		screws[1] = false;
		$screw2.visible = false;


func _on_screw3_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		SoundFx.play_menu("screw")
		screws[2] = false;
		$screw3.visible = false;


func _on_screw4_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		SoundFx.play_menu("screw")
		screws[3] = false;
		$screw4.visible = false;

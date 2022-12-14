extends Control


func _ready():
	Globals.reset()
	$Version/GameVersion.text = ProjectSettings.get_setting("application/config/version")
	$Version/GodotVersion.text = "Godot %s" % Engine.get_version_info().string
	# needed for gamepads to work
	$VBoxContainer/PlayButton.grab_focus()
	if Globals.game_over:
		$VBoxContainer/PlayButton.queue_free()
		$ThanksScreen.visible = true;
	else:
		$ThanksScreen.visible = false;
	if OS.has_feature('HTML5'):
		$VBoxContainer/ExitButton.queue_free()


func _on_PlayButton_pressed() -> void:
	play_menu_select()
	var params = {
		show_progress_bar = true,
		"a_number": 10,
		"a_string": "Ciao mamma!",
		"an_array": [1, 2, 3, 4],
		"a_dict": {
			"name": "test",
			"val": 15
		},
	}
	Game.change_scene("res://scenes/gameplay/gameplay.tscn", params)


func _on_ExitButton_pressed() -> void:
	# gently shutdown the game
	play_menu_select()
	var transitions = get_node_or_null("/root/Transitions")
	if transitions:
		transitions.fade_in({
			'show_progress_bar': false
		})
		yield(transitions.anim, "animation_finished")
		yield(get_tree().create_timer(0.3), "timeout")
	get_tree().quit()


func _on_PlayButton_mouse_entered():
	play_menu_move()


func _on_ExitButton_mouse_entered():
	play_menu_move()
	
func play_menu_move():
	SoundFx.play_menu("menu_move", rand_range(0.2, 0.4))
	
func play_menu_select():
	SoundFx.play_menu("menu_select", rand_range(0.2, 0.4))


extends Node

var elapsed = 0

# `pre_start()` is called when a scene is loaded.
# Use this function to receive params from `Game.change_scene(params)`.
func pre_start(params):
	var cur_scene: Node = get_tree().current_scene
	print("Current scene is: ", cur_scene.name, " (", cur_scene.filename, ")")
	print("gameplay.gd: pre_start() called with params = ")
	if params:
		for key in params:
			var val = params[key]
			printt("", key, val)
	print("Processing...")
	yield(get_tree().create_timer(0), "timeout")
	print("Done")


# `start()` is called when the graphic transition ends.
func start():
	# Reset all things in Globals
	Globals.operator_num += 1;
	Globals.one_fuckup_left = true;
	Globals.paused = true;
	Globals.successful_presses = 0;
	# TODO(): RELOCK DOORS BETWEEN RUNS
	
	Globals.start_world_timer()
	Globals.start_second_timer()
	
	Dialogic.set_variable("operator_number", Globals.operator_num)
	start_dialog("start");

func start_dialog(timeline):
		add_child(Dialogic.start(timeline))


func _process(delta):
	elapsed += delta

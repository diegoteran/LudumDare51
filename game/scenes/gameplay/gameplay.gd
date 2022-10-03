extends Node

var elapsed = 0

export var Z_ROOM : PackedScene

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
	Globals.start_world_timer()
	Globals.start_second_timer()
	
	Dialogic.set_variable("operator_number", Globals.operator_num)
	start_dialog("start");

func start_dialog(timeline):
		add_child(Dialogic.start(timeline))


func _process(delta):
	elapsed += delta

func to_z():
	var instance = Z_ROOM.instance()
	print("some animation here")
	for node in $RoomManager.get_children():
		node.queue_free()
	
	$RoomManager.add_child(instance)

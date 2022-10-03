extends Control

const ROOM_DIR = "res://scenes/rooms/"
const ROOM_SIZE = Vector2(1080, 1920)

export var CurrentRoomScene : PackedScene

var current_room
var adjacent_room_names
var adjacent_rooms = {}

var dirs = ["UP", "RIGHT", "DOWN", "LEFT"]
var dir_to_vec = {"UP": Vector2.UP, "RIGHT" : Vector2.RIGHT, "DOWN": Vector2.DOWN, "LEFT": Vector2.LEFT}
var dir_contra = {"UP": "DOWN", "RIGHT" : "LEFT", "DOWN": "UP", "LEFT": "RIGHT"}

onready var tween = $Tween

enum {
	CURRENT,
	BORDER
}

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create instance of packed scene.
	current_room = CurrentRoomScene.instance()
	add_child(current_room)
	adjacent_room_names = current_room.adjacent_room_names
	current_room.state = CURRENT
	
	set_connections()
	set_adjacent_rooms()

func changed_rooms(dir):
	play_transition(dir)
	leave_room_to(dir)
	
	current_room.state = BORDER
	adjacent_rooms[dir_contra[dir]] = current_room
	
	current_room = adjacent_rooms[dir]
	current_room.state = CURRENT
	adjacent_room_names = current_room.adjacent_room_names
			
	
	adjacent_rooms.erase(dir)
	set_connections()
	set_adjacent_rooms()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_connections():
	current_room.connect("click_move", self, "move")

func leave_room_to(dir):
	current_room.disconnect("click_move", self, "move")
	remove_adjacent_rooms_except(dir)

func set_adjacent_rooms() -> void:
	print("******ENTERED ROOM*******")
	print("This room "+ current_room.name +" generated :")
	for dir in dirs:
		add_adjacent_room(dir)

func add_adjacent_room(dir):
	if adjacent_room_names[dir] != "" and !(dir in adjacent_rooms.keys()):
		print(adjacent_room_names[dir])
		adjacent_rooms[dir] = load(ROOM_DIR + adjacent_room_names[dir] + ".tscn").instance()
		add_child(adjacent_rooms[dir])
		adjacent_rooms[dir].name = adjacent_room_names[dir]
		adjacent_rooms[dir].position += dir_to_vec[dir] * (ROOM_SIZE.x if dir in ("UP, DOWN") else ROOM_SIZE.y)

func remove_adjacent_rooms_except(exception) -> void:
	for dir in dirs:
		if dir in adjacent_rooms.keys() and adjacent_rooms[dir] != null and dir != exception:
			remove_child(adjacent_rooms[dir])
			adjacent_rooms.erase(dir)

func move(dir):
	if !(dir in adjacent_rooms.keys()):
		print("No room " + dir)
		return
	
	if tween.is_active():
		print("tween active")
		return
	
	tween.interpolate_property(current_room, "position", current_room.position, dir_to_vec[dir_contra[dir]] * (ROOM_SIZE.x if dir in ("UP, DOWN") else ROOM_SIZE.y), 1.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.interpolate_property(adjacent_rooms[dir], "position", adjacent_rooms[dir].position, Vector2.ZERO, 1.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	
	changed_rooms(dir)

func play_transition(dir):
	SoundFx.play("transition", dir_to_vec[dir] * 100, rand_range(0.35, 0.4))

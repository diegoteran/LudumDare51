extends Node

var sounds_path = "res://sound/sounds/"

# Keep sorted please
var sounds = {
	"close_door" : load(sounds_path + "close_door.wav"),
	"down" : load(sounds_path + "down.wav"),
	"egg" : load(sounds_path + "egg.wav"),
	"fail" : load(sounds_path + "fail.wav"),
	"journal" : load(sounds_path + "journal.wav"),
	"key_falls" : load(sounds_path + "key_falls.wav"),
	"menu_move" : load(sounds_path + "menu_move.wav"),
	"menu_select" : load(sounds_path + "menu_select.wav"),
	"left" : load(sounds_path + "left.wav"),
	"locked_door" : load(sounds_path + "locked_door.wav"),
	"paper" : load(sounds_path + "paper.wav"),
	"pull" : load(sounds_path + "pull.wav"),
	"right" : load(sounds_path + "right.wav"),
	"screw" : load(sounds_path + "screw.wav"),
	"shake" : load(sounds_path + "shake.wav"),
	"space" : load(sounds_path + "space.wav"),
	"teleport" : load(sounds_path + "teleport.wav"),
	"thunder" : load(sounds_path + "thunder.wav"),
	"tick" : load(sounds_path + "tick.wav"),
	"tock" : load(sounds_path + "tock.wav"),
	"transition" : load(sounds_path + "transition.wav"),
	"unlock_door" : load(sounds_path + "unlock_door.wav"),
	"up" : load(sounds_path + "up.wav"),
}

onready var sound_players = get_node("2D").get_children()
onready var sound_players_menu = get_node("Menu").get_children()

func play(sound_string, from_location, pitch_scale = 1, volume_db = 0):
	for soundPlayer in sound_players:
		if not soundPlayer.playing:
			soundPlayer.attenuation = 10
			soundPlayer.pitch_scale = pitch_scale
			soundPlayer.volume_db = volume_db
			soundPlayer.stream = sounds[sound_string]
			soundPlayer.global_position = Game.size/2 + from_location
			soundPlayer.play()
			return
	print("Too many sounds playing at once.")

func play_menu(sound_string, pitch_scale = 1, volume_db = 0):
	for soundPlayer in sound_players_menu:
		if not soundPlayer.playing:
			soundPlayer.pitch_scale = pitch_scale
			soundPlayer.volume_db = volume_db
			soundPlayer.stream = sounds[sound_string]
			soundPlayer.play()
			return
	print("Too many sounds playing for menu at once.")

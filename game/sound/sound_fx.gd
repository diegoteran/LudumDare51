extends Node

var sounds_path = "res://sound/sounds/"

var sounds = {
	"menu_move" : load(sounds_path + "menu_move.wav"),
	"menu_select" : load(sounds_path + "menu_select.wav"),
	"transition" : load(sounds_path + "transition.wav"),
	"unlock_door" : load(sounds_path + "unlock_door.wav"),
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

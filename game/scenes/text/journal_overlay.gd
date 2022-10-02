extends "res://scenes/text/text_template.gd"


func _ready():
	pages = JournalManager.get_pages();
	._ready();

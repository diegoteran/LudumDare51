extends "res://scenes/text/text_template.gd"


func setup_pages():
	pages = [];
	file_pages = ["JOURNALZ.txt"]
	
func close():
	Globals.start_final_timer();

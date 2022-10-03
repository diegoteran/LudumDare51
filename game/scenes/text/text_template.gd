extends Node2D

var currentPage = 0;
var pages = ["Test", "Cool"]
var file_pages = [];
var discoverable_info = {}

var numPages;

func _ready():
	setup_pages();
	if  pages.size() == 0:
		if file_pages.size() > 0:
			read_pages_from_files();
			
	if pages.size() == 0:
		queue_free();
	
	numPages = pages.size();
	
	if numPages == 1:
		$Background/ButtonRight.visible = false;
		$Background/ButtonRight.disabled = true;
		$"Background/Page Count".visible = false;
	
	update_page(currentPage);

func setup_pages():
	pass;

func read_pages_from_files():
	for filepath in file_pages:
		var new_page = get_file_content(filepath);
		if new_page.length() > 0:
			pages.append(new_page);

func get_file_content(filepath):
	var f = File.new()
	var returnString = "";
	var full_filepath = "res://assets/text/" + filepath;
	f.open(full_filepath, File.READ)
	while not f.eof_reached():
		var line = f.get_line()
		line += " "
		returnString += (line + "\n")
	f.close()
	return returnString


func update_page(page):
	SoundFx.play_menu("paper")
	
	currentPage = page;
	$Background/Content.bbcode_text = pages[currentPage];
	
	if discoverable_info.has(page):
		for info in discoverable_info[page]:
			JournalManager.add_info(info);
	
	$"Background/Page Count".bbcode_text = "[center]" + str(currentPage+1) + "/" + str(numPages) + "[/center]";
	if currentPage == 0:
		$Background/ButtonLeft.visible = false;
		$Background/ButtonLeft.disabled = true;
	else:
		$Background/ButtonLeft.visible = true;
		$Background/ButtonLeft.disabled = false;
	if (currentPage+1) == numPages:
		$Background/ButtonRight.visible = false;
		$Background/ButtonRight.disabled = true;
	else:
		$Background/ButtonRight.visible = true;
		$Background/ButtonRight.disabled = false;

func _on_ButtonRight_pressed():
	update_page(currentPage+1);
	pass # Replace with function body.


func _on_ButtonLeft_pressed():
	update_page(currentPage-1);
	pass # Replace with function body.

func close():
	pass;

func _on_Button_pressed():
	Globals.unpause();
	close();
	queue_free();
	pass # Replace with function body.

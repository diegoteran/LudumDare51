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
		$ColorRect/ButtonRight.visible = false;
		$ColorRect/ButtonRight.disabled = true;
		$"ColorRect/Page Count".visible = false;
	
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
	var index = 1
	while not f.eof_reached():
		var line = f.get_line()
		line += " "
		returnString += (line + "\n")
		index += 1
	f.close()
	return returnString


func update_page(page):
	currentPage = page;
	$ColorRect/Content.text = pages[currentPage];
	
	if discoverable_info.has(page):
		for info in discoverable_info[page]:
			JournalManager.add_info(info);
	
	$"ColorRect/Page Count".bbcode_text = "[center]" + str(currentPage+1) + "/" + str(numPages) + "[/center]";
	if currentPage == 0:
		$ColorRect/ButtonLeft.visible = false;
		$ColorRect/ButtonLeft.disabled = true;
	else:
		$ColorRect/ButtonLeft.visible = true;
		$ColorRect/ButtonLeft.disabled = false;
	if (currentPage+1) == numPages:
		$ColorRect/ButtonRight.visible = false;
		$ColorRect/ButtonRight.disabled = true;
	else:
		$ColorRect/ButtonRight.visible = true;
		$ColorRect/ButtonRight.disabled = false;

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print("clicked");
		queue_free();


func _on_ButtonRight_pressed():
	update_page(currentPage+1);
	pass # Replace with function body.


func _on_ButtonLeft_pressed():
	update_page(currentPage-1);
	pass # Replace with function body.

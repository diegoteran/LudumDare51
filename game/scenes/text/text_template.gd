extends Node2D

var currentPage = 0;
var pages = ["test", "test 2", "This is the third page"]
var numPages;

func _ready():
	numPages = pages.size();
	
	if numPages < 0:
		queue_free();
	if numPages == 1:
		$ColorRect/ButtonRight.visible = false;
		$ColorRect/ButtonRight.disabled = true;
		$"ColorRect/Page Count".visible = false;
	
	update_page(currentPage);
	

func update_page(page):
	currentPage = page;
	$ColorRect/Content.text = pages[currentPage];
	
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

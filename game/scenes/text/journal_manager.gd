extends Node

var info_dict = {
	"titleL" : "The Lever",
	"L1" : "For whom does the bell toll?",
	"titleA" : "The Room",
	"A1" : "I woke up in a strange room, where am I?",
	"A2" : "ppl be emailing",
	"A3" : "Woaaaah",
}

# Each Page is a different mystery
var pages = [["titleL", "L1"], ["titleA", "A1", "A2", "A3"]]
var info_discovered = ["titleL", "L1", "titleA", "A1"];


func add_info(info):
	if not info in info_discovered:
		info_discovered.append(info);

func get_pages():
	print("getting current pages")
	var curr_pages = [];
	var page_content;
	for page in pages:
		page_content = "";
		for info in page:
			if info in info_discovered:
				page_content += info_dict[info] + "\n\n";
		
		if page_content.length() > 0:
			curr_pages.append(page_content);

	
	return curr_pages;


extends Node

var info_dict = {
	"titleL" : "The Lever",
	"L1" : "For whom does the bell toll?",
	"L2" : "A voice told me I need to pull the lever every 10 seconds or I’ll be replaced..",
	"L3" : "What's that sound after I pull the lever?",
	"L4" : "I can remove the lever from the wall by clicking the four screws! Now I can safely explore this place.",
	"L5" : "The man in the room next door said the lever was a lie, that the magic is in me, what does that mean?",
	"titleM" : "The Magic",
	"M1" : "I can perform magic by clicking and holding the mouse and tracing patterns",
	"M2" : "If I trace from left to right, as if I’m pulling the lever, I can reset the timer, even without the lever.",
	"M3" : "If I trace the square found on the wall of room B, something happens [M3] [Unlock: time pattern in room",
	"M3b" : "By tracing the square, I can make day into night and vice versa",
	"M4" : "There's a symbol to unlock objects hidden behind the safe in the office, locked behind a temporal lock.",
	"M4b" : "If I trace the hourglass symbol found in the safe of room I can unlock doors",
	"M5" : "On the chalkboard there's a few patterns for something called the machine room",
	"M5b" : "If I perform a sequence of patterns, right, down, up, left, down,, I get brought to the machine room.",
	"titleA" : "The Room",
	"A1" : "I woke up in a strange room, where am I?",
	"A2" : "If I click on the flower pot enough times, a key comes out and the door opens.",
	"A3" : "If I pull on the flower pot hook for 4 seconds, a computer terminal comes down.",
	"titleB" : "The Room Next Door",
	"B1" : "There’s a computer with a broken flower pot in the first section of the room, which looks similar to my room.",
	"B2" : "There's a notebook in this room, it looks like someone went crazy in here. Looks like they opened their computer by pulling down on the flower pot hook for 4 seconds. I wonder if I can do something similar…",
	"B3" : "There's a pattern drawn in blood in this room.. What can it mean? ",
	"titleD" : "The Office",
	"D1" : "It looks like the office door is locked soon after the start of my shifts. If only I could have gotten there early enough..",
	"D2" : "I was able to get into the office by running to it at the start of my shift",
	"D3" : "There's a chalkboard in here with lots of symbols",
	"D4" : "There's a safe somewhere in here, I wonder where it is?",
	"D4b" : "The safe is behind the remarkable egg painting!",
	"D5" : "The safe had some sort of temporal lock on it, I wonder if the hourglass is related?",
	"D5b" : "By using the time spell, I can open the safe!",
	"titleC" : "The Bell Tower",
	"C1" : "There's a strange pattern on the wall in this room",
	"C2" : "Oh a bell, there was a bell on the chalkboard in the office right?",
	"C3" : "When I ring the bell, a song is played.",
}

# Each Page is a different mystery
var pages = [["titleL", "L1", "L2", "L3", "L4", "L5"], ["titleM", "M1", "M2", "M3", "M3b", "M4", "M4b", "M5", "M5b"],
 ["titleA", "A1", "A2", "A3"], ["titleB", "B1", "B2", "B3"], ["titleD", "D1", "D2", "D3", "D4", "D4b", "D5", "D5b"],
["titleC", "C1", "C2", "C3"],]
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


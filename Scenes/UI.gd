extends Node2D

# Declare member variables here. Examples:
onready var StartList = $MenuButtons/StartList
onready var Title = $Title
var items : Array = read_json_file("JSON/tasksList.json")
var item : Dictionary
var index_item : int = 0

# initializes list for the file names of the icons
var iconList = []

# Called when the node enters the scene tree for the first time.
func _ready():
	print("ui is ready")
	pass
	

# reads the json file
func read_json_file(filename):
	var file = File.new()
	file.open(filename, file.READ)
	var text = file.get_as_text()
	var json_data = parse_json(text)
	file.close()
	return json_data

# recognizes click in the ItemList node called StartList
func _on_StartList_item_selected(index):
	
	#if start is clicked, displays all task names
	if (StartList.get_item_text(index) == "Start"):
		StartList.clear()
		for x in range(items.size()):
			item = items[x]
			var tasks = item.task
			StartList.add_item(tasks)


	# if wash hands is clicked, outputs the names of the steps
	elif (StartList.get_item_text(index) == "Wash Hands"):
		StartList.clear()
		item = items[0]
		for x in item.steps.size():
			var steps = item["steps"][x]
			StartList.add_item(steps)
		#var size = item.icons.size()
		#iconList.resize(size)
		#iconList = item.icons
		#shuffleList(iconList)
		get_tree().change_scene("res://mainthing.tscn")
		print(get_tree().get_current_scene())
		InputControl.N = 5

	elif (StartList.get_item_text(index) == "Brush Teeth"):
		StartList.clear()
		item = items[1]
		for x in item.steps.size():
			var steps = item["steps"][x]
			StartList.add_item(steps)
	
	elif (StartList.get_item_text(index) == "Shower"):
		StartList.clear()
		item = items[2]
		for x in item.steps.size():
			var steps = item["steps"][x]
			StartList.add_item(steps)

# randomizes the file names in "IconList"
func shuffleList(list):
	randomize()
	list.shuffle()
	return list


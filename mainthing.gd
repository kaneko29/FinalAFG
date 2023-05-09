extends Node2D

#Number of tasks
var N = 7

#Size of screen
var screenx
var screeny
signal value_updated(value)

#Size of rectangles
var rx 
var ry 

#Scaling factor
var dx = 0.9
var dy = 0.8

var scl = 0.9
#Questions and ansslots store the dropzones, one for the left column the 
#other for the right
var questions = []
var ansslots = []

#Stores all the tasks
var answers = []

#The name of the current activity
var activity = "tooth"

#Gets the button 
onready var childButton: Button = self.get_child(0) 

#Starts the program!
func _ready():
	print("mainthing is ready")
	N = InputControl.N
	#connects to the button
	childButton.connect("pressed", self, "anscheck")
	
	#Gets the size of the viewport/screen
	screenx = get_viewport().size.x 
	screeny = get_viewport().size.y
	rx = screenx * dx / 2
	ry = dy * screeny / N
	
	#makes the array a certain length
	questions.resize(N)
	answers.resize(N)
	ansslots.resize(N)
	
	#Loads the dropzones in, creates instance and initiliazes them
	for i in range(N):
		questions[i] = preload("res://DropZone.tscn").instance()
		questions[i].init( (screenx - 2 * rx)/3, (screeny - N * ry)/(N+1) * (i+1) + (ry) * i, rx, ry, Color.blue, true)
		add_child(questions[i])
	for i in range(N):
		ansslots[i] = preload("res://DropZone.tscn").instance()
		ansslots[i].init(rx + 2 * (screenx - 2 * rx)/3,  (screeny - N * ry)/(N+1) * (i+1) + (ry) * i, rx, ry, Color.red, false)
		add_child(ansslots[i])	
	
	#Random initial ordering of the images
	# Define the size of the array
	
# Create an array of numbers from 0 to n-1
	var imgorder = [1,2,3,4,5,6,7]
	imgorder.shuffle()

	#Creates array of image links
	var imgarray=[]
	for i in range(N):
		imgarray.append("res://" + activity + "/" + activity + str(imgorder[i]) + ".png")
	
	#Loads the task stuff and initializes it
	for i in range(N):
		answers[i] = preload("res://appsforzgood.tscn").instance()
		answers[i].init(rx / 6, (screeny - N * ry)/(N+1) * (i+1) + (ry) * i, rx, ry, questions[i], imgarray[i], imgorder[i], scl)
		add_child(answers[i])
	for i in range(N):
		questions[i].addans(answers[i])


#Checks if the answers are correct, called when the button is pressed
func anscheck():
	print(N)
	var counter = 0
	for i in range(N):
		#checks if the dropzone is not empty and the task inside of it
		#is in the correct location
		if ansslots[i].ans != null and ansslots[i].ans.ordernum == i+1:
			ansslots[i].change_color(Color.green)
			counter += 1
		else:
			ansslots[i].change_color(Color.red)
	#if everything is correct
	if counter == N:
		print("you got everything correct!")


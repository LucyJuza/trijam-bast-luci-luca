extends Node

var score = 0;
var is_digging =false;
var displacement_delay = 0.05
signal score_updated
signal displacement_time_updated
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_score(scoreUp):
	score = scoreUp
	score_updated.emit()
	pass
	
func dig():
	print("started digging")
	is_digging = true
	pass
	
func stop_digging():
	print("stopped digging")
	is_digging = false;
	pass

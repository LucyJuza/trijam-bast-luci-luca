extends Node

var score = 0;
var is_digging =false;
signal score_updated
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
	is_digging = true
	pass
func stop_digging():
	is_digging = false;
	pass

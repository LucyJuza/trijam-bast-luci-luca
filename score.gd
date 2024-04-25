extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.score_updated.connect(updating)
	pass # Replace with function body.

func updating():
	text = str(Global.score)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

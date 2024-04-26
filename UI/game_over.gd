extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$PanelContainer/MarginContainer/Rows/score.text = "SCORE: " + str(Global.score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://UI/main.tscn")


func _on_quit_button_pressed():
	get_tree().quit()

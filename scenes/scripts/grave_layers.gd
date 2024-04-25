extends TextureRect

var current_layer = 0
var layers

func _ready():
	layers = [
		%Layer1,
		%Layer2,
		%Layer3,
		%Layer4,
		%Layer5
	]
	
	update_layers()

func update_layers():
	for layer in layers :
		layer.global_position = global_position
		layer.visible = false
	
	layers[current_layer].visible = true

func cycle_layers():
	if current_layer < layers.size() - 1 :
		current_layer+=1
	update_layers()

extends Node

var score = 0;
var is_digging =false;
var displacement_delay = 0.05
var tombs = [{"pos": Vector2i(0,0), "hps": 100,"damages_dealt": 0,"zombied": false}]
var lastDugTomb = null;
signal score_updated
signal digging_updated
signal displacement_time_updated
signal grave_screen_updated
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_grave_screen(hps_damage_dealt):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_score(scoreUp):
	score += scoreUp
	if (score % 5) == 0:
		displacement_delay += 0.05
		displacement_time_updated.emit()
	score_updated.emit()
	pass
	
func dig(tile_position: Vector2i):
	print("started digging")
	var flag = false;
	for tomb in tombs:
		if tomb["pos"] == tile_position:
			flag = true;
			grave_screen_updated.emit(tomb["hps"],tomb["damages_dealt"])
			if (tomb["hps"] > 0) and (not tomb["zombied"]):
				is_digging = true
		lastDugTomb = tomb
	if not flag:
		lastDugTomb = {"pos": tile_position, "hps": 100, "damages_dealt":0, "zombied": false}
		tombs.push_back(lastDugTomb)
		grave_screen_updated.emit(100,0)
		is_digging = true
	digging_updated.emit()
	pass
	
func stop_digging():
	is_digging = false;
	digging_updated.emit()
	pass

func update_last_dug_infos(hps,damages,zombied):
	var lastDugIndex = tombs.find(lastDugTomb)
	if lastDugIndex != -1:
		tombs[lastDugIndex]["hps"] = hps
		tombs[lastDugIndex]["damages_dealt"] = damages 
		tombs[lastDugIndex]["zombied"] = zombied 

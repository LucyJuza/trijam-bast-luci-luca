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
	
func dig(tile_position: Vector2i):
	#print("started digging")
	var flag = false;
	for tomb in tombs:
		if tomb["pos"] == tile_position:
			#print("found tomb: " + str(tomb))
			flag = true;
			grave_screen_updated.emit(tomb["hps"],tomb["damages_dealt"],tomb["zombied"])
			if (tomb["hps"] > 0) and (not tomb["zombied"]):
				#print("status of zombied for: " + str(tomb["zombied"]))
				#print("is not zombied and hps > 0")
				is_digging = true
			else: is_digging = false
			lastDugTomb = tomb
		
	if not flag:
		lastDugTomb = {"pos": tile_position, "hps": 100, "damages_dealt":0, "zombied": false}
		tombs.push_back(lastDugTomb)
		grave_screen_updated.emit(100,0,false)
		is_digging = true
	digging_updated.emit(is_digging)

	
func stop_digging():
	is_digging = false;
	digging_updated.emit(is_digging )

func update_last_dug_infos(hps,damages,zombied):
	#print("last dug is: " + str(lastDugTomb))
	for tomb in tombs:
		if tomb["pos"] == lastDugTomb["pos"]:
			tomb["hps"] = hps
			tomb["damages_dealt"] = damages 
			tomb["zombied"] = zombied 

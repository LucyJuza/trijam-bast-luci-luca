extends CanvasLayer

# Damage dealt per hit
const DAMAGE_PER_DIG = 2.5
# Damage needed to cycle grave layers
const DAMAGE_THRESHOLD = 25
const MAX_HP = 100.0
# The threshold below which monsters will have a chance to spawn
const MONSTER_HP_THRESHOLD = 50.0

# Current grave HP
var health
# To keep track of tomb cycles
var damage_dealt
var monster_spawn
var treasure_spawn
var zombied
func _ready():
	Global.digging_updated.connect(digUpdate)
	Global.grave_screen_updated.connect(update_display)
	
	init(100.0)

func digUpdate(value):
	visible = value
	if not value:
		Global.update_last_dug_infos(health, damage_dealt, zombied)

func _physics_process(delta):
	#print(str(Global.tombs))
	if Global.is_digging:
		var digging = Input.is_action_just_pressed("interact")
		if digging and !monster_spawn:
			dig()

func init(wanted_health) :
	%GraveLayers.current_layer = 0;
	%GraveLayers.update_layers();
	health = wanted_health
	damage_dealt = 0
	monster_spawn = 0
	treasure_spawn = 0
	zombied = false
	
func update_display(current_health,current_damage_dealt,curr_zombied):
	if current_health <= MAX_HP and current_health > 75 :
		%GraveLayers.current_layer = 0
		%GraveLayers.update_layers()
	if current_health <= 75 and current_health > 50:
		%GraveLayers.current_layer = 1
		%GraveLayers.update_layers()
	if current_health <= 50 and current_health > 25:
		%GraveLayers.current_layer = 2
		%GraveLayers.update_layers()
	if current_health <= 50 and current_health > 25:
		%GraveLayers.current_layer = 3
		%GraveLayers.update_layers()
	if current_health <= 25 and current_health > 0:
		%GraveLayers.current_layer = 4
		%GraveLayers.update_layers()
	health = current_health
	%ProgressBar.value = health
	damage_dealt = current_damage_dealt;
	monster_spawn = 0
	treasure_spawn = 0
	zombied = curr_zombied

func dig():
	if health > 0:
		health -= DAMAGE_PER_DIG
		damage_dealt += DAMAGE_PER_DIG
		%ProgressBar.value = health
		
		if damage_dealt >= DAMAGE_THRESHOLD:
			damage_dealt = 0
			$shovel.play()
			%GraveLayers.cycle_layers()
			
		if health < MONSTER_HP_THRESHOLD:
			monster_spawn = randf() > health / MONSTER_HP_THRESHOLD
		
		treasure_spawn = randf() > health / MAX_HP
		
		if treasure_spawn :
			Global.update_score(1)
		
		if monster_spawn :
			zombied = true
			$zombie.play()
			print("ZOMBIIIIIIE!!!!!!")
			Global.stop_digging()
			Global.game_over()
	else:
		Global.stop_digging()

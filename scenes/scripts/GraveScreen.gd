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
var treasures_gotten

func _ready():
	init(100.0)

func _physics_process(delta):
	var digging = Input.is_action_just_pressed("interact")
	if digging and !monster_spawn:
		dig()

func init(wanted_health) :
	health = wanted_health
	damage_dealt = 0
	monster_spawn = 0
	treasure_spawn = 0
	treasures_gotten = 0

func dig():
	health -= DAMAGE_PER_DIG
	damage_dealt += DAMAGE_PER_DIG
	%ProgressBar.value = health
	
	if damage_dealt >= DAMAGE_THRESHOLD:
		damage_dealt = 0
		%GraveLayers.cycle_layers()
	
	if health < MONSTER_HP_THRESHOLD:
		monster_spawn = randf() > health / MONSTER_HP_THRESHOLD
	
	treasure_spawn = randf() > health / MAX_HP
	
	if treasure_spawn :
		treasures_gotten += 1
	%TreasuresGotten.text = str(treasures_gotten)
	
	if monster_spawn :
		%Zombie.text = "Zombie"
	

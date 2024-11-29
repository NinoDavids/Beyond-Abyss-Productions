extends GridMap
class_name Puzzle

@export var water_sprouts: Array[WaterSpout]
@export var active: bool= false
@export var next_puzzle: Puzzle

func _ready() -> void:
	if water_sprouts.size() > 0 && active:
		water_sprouts[0].active = true

# Called when the node enters the scene tree for the first time.
func next_water_sprout() -> void:
	if water_sprouts.size() > 0:
		water_sprouts[0].active = false
		water_sprouts.remove_at(0)
		
		if water_sprouts.size() > 0:
			water_sprouts[0].active = true
		elif next_puzzle.water_sprouts.size() > 0:
			next_puzzle.water_sprouts[0].active = true

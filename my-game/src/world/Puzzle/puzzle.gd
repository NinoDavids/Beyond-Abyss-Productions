extends GridMap
class_name Puzzle

@export var water_spouts: Array[WaterSpout]
@export var active: bool= false
@export var next_puzzle: Puzzle

func _ready() -> void:
	if water_spouts.size() > 0 && active:
		water_spouts[0].active = true

# Called when the node enters the scene tree for the first time.
func next_water_spout() -> void:
	if water_spouts.size() > 0:
		water_spouts[0].active = false
		water_spouts.remove_at(0)

		if water_spouts.size() > 0:
			water_spouts[0].active = true
		elif next_puzzle.water_spouts.size() > 0:
			next_puzzle.water_spouts[0].active = true

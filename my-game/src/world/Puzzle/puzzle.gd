extends GridMap
class_name Puzzle

@onready var checkpoint: Checkpoint = $Checkpoint

@export var bridge: Bridge

@export var water_spouts: Array[WaterSpout]
@export var active: bool = false:
	set(value):
		active = value
		if checkpoint:
			checkpoint.is_active = value
@export var next_puzzle: Puzzle

func _ready() -> void:
	if water_spouts.size() > 0 && active:
		water_spouts[0].active = true
	
	if checkpoint:
		checkpoint.is_active = active

# Called when the node enters the scene tree for the first time.
func next_water_spout() -> void:
	if water_spouts.size() > 0:
		water_spouts[0].active = false
		water_spouts.remove_at(0)



		if water_spouts.size() > 0:
			water_spouts[0].active = true
		elif next_puzzle.water_spouts.size() > 0:
			if bridge != null:
				bridge.progress()
			next_puzzle.active = true
			next_puzzle.water_spouts[0].active = true

extends MeshInstance3D

var mesh_data: MeshDataTool = MeshDataTool.new()

const FLYING_FISH: PackedScene = preload("res://src/actors/Fish/flying_fish.tscn")
@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _on_timer_timeout() -> void:
	pass
	
	
	

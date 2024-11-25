extends StaticBody3D

@export var water: Water
@export var water_height: int

@onready var button: AnimatableBody3D = $Button
@onready var animationPlayer: AnimationPlayer = $Button/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Bobber:
		animationPlayer.play('in')
		if water != null:
			water.raise_water(water_height)
		

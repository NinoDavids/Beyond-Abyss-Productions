extends AnimatableBody3D

@onready var checkpoint_handler: CheckpointHandler = $CheckpointHandler

@export_group("Checkpoint Handling")
@export var checkpoint: LegacyCheckpoint

func _ready() -> void:
	checkpoint_handler.checkpoint = checkpoint

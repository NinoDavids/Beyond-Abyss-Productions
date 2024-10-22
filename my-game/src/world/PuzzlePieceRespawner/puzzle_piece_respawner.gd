extends Area3D

@export var despawnParticles: PackedScene
@export var respawnParticles: PackedScene
@onready var effect_timer: Timer = $EffectTimer

func _on_body_entered(body: Node3D) -> void:
	if body.find_child("CheckpointHandler"):
		var handler: CheckpointHandler = body.find_child("CheckpointHandler") as CheckpointHandler
		despawn_effect(body)
		handler.load_object()
		respawn_effect(body)
		await effect_timer.timeout
		body.visible = true

func despawn_effect(body: Node3D) -> void:
	var effect: CPUParticles3D = despawnParticles.instantiate() as CPUParticles3D
	effect.finished.connect(destroy_effect)
	body.visible = false
	add_child(effect)
	effect.global_position = body.global_position
	effect.emitting = true

func respawn_effect(body: Node3D) -> void:
	var effect: CPUParticles3D = respawnParticles.instantiate() as CPUParticles3D
	effect.finished.connect(destroy_effect)
	add_child(effect)
	effect.global_position = body.global_position
	effect_timer.wait_time = effect.lifetime
	effect.emitting = true
	effect_timer.start()

func destroy_effect() -> void:
	for child: Node in get_children():
		if child is CPUParticles3D:
			child.queue_free()

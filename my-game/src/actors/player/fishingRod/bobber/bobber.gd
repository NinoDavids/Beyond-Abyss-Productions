extends Floatable
class_name Bobber

var player: Player
var is_attached: bool = false

func _ready() -> void:
	EventManager.anim_hookable_finished.connect(handleAnimHookableFinished)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel_hook"):
		queue_free()

func set_hooked(pos: Vector3) -> void:
	global_position = pos
	is_attached = true

func handleAnimHookableFinished() -> void:
	queue_free()

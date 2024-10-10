extends Area3D

@onready var regen_timer: Timer = $RegenTimer

@export var max_health: float = 100.0
var current_health: float

func _ready() -> void:
	current_health = max_health

func _on_body_entered(_body: Node3D) -> void:
	take_damage()
	regen_timer.start()

func take_damage() -> void:
	current_health -= 10
	print_debug(current_health)


func _on_regen_timer_timeout() -> void:
	print("Timer ended.")

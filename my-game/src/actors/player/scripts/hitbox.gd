extends Area3D
class_name Hitbox

@onready var respawn_timer: Timer = $RespawnTimer
@onready var regen_timer: Timer = $RegenTimer
var is_regenning: bool = false
var count: float

@export var max_health: float = 3
var current_health: float

func _ready() -> void:
	current_health = max_health

func _process(delta: float) -> void:
	if is_regenning:
		count += delta
		if count >= 2:
			current_health += 1
		if current_health >= max_health:
			current_health = max_health
			is_regenning = false
			count = 0

func _on_body_entered(body: Node3D) -> void:
	
	take_damage()
	regen_timer.start()

func take_damage(damage: float = 1) -> void:
	current_health -= damage
	if current_health <= 0:
		respawn_timer.start()
		EventManager.player_died.emit()
	else:
		EventManager.player_damaged.emit()

func _on_regen_timer_timeout() -> void:
	EventManager.player_regenerating.emit()
	is_regenning = true

func _on_area_entered(_area: Area3D) -> void:
	take_damage()
	regen_timer.start()

func _on_respawn_timer_timeout() -> void:
	EventManager.player_respawned.emit()
	current_health = max_health

extends ColorRect

var shader: ShaderMaterial
@export var timer: Timer
var screen_shake = .5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventManager.player_damaged.connect(handle_player_damaged)
	EventManager.player_died.connect(handle_player_died)
	EventManager.player_regenerating.connect(handle_player_regen)
	shader = material



func handle_player_damaged() -> void:
	print("damaged")
	timer.start()
	screen_shake += .5
	shader.set_shader_parameter("ShakeStrength", screen_shake)


func _on_timer_timeout() -> void:
	shader.set_shader_parameter("ShakeStrength", 0)

	
func handle_player_died():
	screen_shake = 1

func handle_player_regen():
	screen_shake = 1

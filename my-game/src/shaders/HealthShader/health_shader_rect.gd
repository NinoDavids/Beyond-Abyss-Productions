extends ColorRect
class_name HealthShaderRect
## Must be placed under a canvaslayer.
var shader: ShaderMaterial
var transparency: float = 0.25

var regenerating: bool = false
var player_died: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventManager.player_damaged.connect(handle_player_damaged)
	EventManager.player_regenerating.connect(handle_player_regenerating)
	EventManager.player_died.connect(handle_player_death)
	EventManager.player_respawned.connect(handle_player_respawn)
	shader = material

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if regenerating and transparency > 0.25:
		transparency -= delta
		shader.set_shader_parameter("alpha", transparency)
		if transparency < 0.25:
			transparency = 0.25
			shader.set_shader_parameter("alpha", 0)
			regenerating = false
	if player_died:
		transparency += delta
		if transparency <= 1:
			shader.set_shader_parameter("alpha", transparency)
		else:
			transparency *= 1.05
		if transparency >= 3:
			shader.set_shader_parameter("brightness", transparency)

func handle_player_damaged() -> void:
	transparency += 0.25
	shader.set_shader_parameter("alpha", transparency)
	regenerating = false

func handle_player_regenerating() -> void:
	regenerating = true

func handle_player_death() -> void:
	player_died = true

func handle_player_respawn() -> void:
	player_died = false
	transparency = 0.25
	shader.set_shader_parameter("alpha", 0)
	shader.set_shader_parameter("brightness", 3)

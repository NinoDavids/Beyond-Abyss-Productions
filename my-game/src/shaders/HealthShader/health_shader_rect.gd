extends ColorRect
class_name HealthShaderRect
## Must be placed under a canvaslayer.


var shader: ShaderMaterial
var transparency: float = 0.25

var regenerating: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventManager.player_damaged.connect(handle_player_damaged)
	EventManager.player_regenerating.connect(handle_player_regenerating)
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

func handle_player_damaged() -> void:
	transparency += 0.25
	shader.set_shader_parameter("alpha", transparency)
	regenerating = false

func handle_player_regenerating() -> void:
	regenerating = true

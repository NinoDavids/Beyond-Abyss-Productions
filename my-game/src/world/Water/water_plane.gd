@tool
extends MeshInstance3D

var material: ShaderMaterial
var noise: Image

@export var noise_scale: float = 10.0
@export var wave_speed: float = 0.025
@export var height_scale: float = 0.15

var time: float

@export var calculateWavesButton: bool = false : set = set_button

func set_button(new_value: bool) -> void:
	calculateWaves()

func calculateWaves() -> void:
	material = self.get_surface_override_material(0)
	noise = material.get_shader_parameter("wave").noise.get_seamless_image(512, 512)
	
	material.set_shader_parameter("noise_scale", noise_scale) 
	material.set_shader_parameter("time_scale", wave_speed) 
	material.set_shader_parameter("height_scale", height_scale) 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	calculateWaves()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	material.set_shader_parameter("wave_time", time)

func get_height(world_position: Vector3) -> float:
	var uv_x: float = wrapf(world_position.x / noise_scale + time * wave_speed, 0, 1)
	var uv_y: float = wrapf(world_position.z / noise_scale + time * wave_speed, 0, 1)

	var pixel_pos: Vector2 = Vector2(uv_x * noise.get_width(), uv_y * noise.get_height())
	return (global_position.y + 0.13  ) + noise.get_pixelv(pixel_pos).r * height_scale

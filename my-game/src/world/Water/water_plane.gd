extends MeshInstance3D

class_name WaterPlane

@export var player: Player

var material: ShaderMaterial
var noise: Image
var noise2: Image
var noise3: Image

@export var noise_scale: float = 10.0
@export var wave_speed: float = 0.025
@export var height_scale: float = 0.15
var time: float
@export var shoot_height:int

const FLYING_FISH: PackedScene = preload("res://src/actors/Fish/flying_fish.tscn")
@export var timer: Timer

@export_range(0, 2, 0.1) var fish_spawn_time: float

@export var calculateWavesButton: bool = false : set = set_button

func set_button(_new_value: bool) -> void:
	calculateWaves()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	calculateWaves()
	if timer != null:
		timer.start()
		timer.timeout.connect(_on_timer_timeout)
		timer.wait_time = fish_spawn_time

func calculateWaves() -> void:
	material = self.get_surface_override_material(0)
	noise = material.get_shader_parameter("wave").noise.get_seamless_image(512, 512)
	noise2 = material.get_shader_parameter("texture_normal").noise.get_seamless_image(512, 512)
	noise3 = material.get_shader_parameter("texture_normal2").noise.get_seamless_image(512, 512)
	

	material.set_shader_parameter("noise_scale", noise_scale)
	material.set_shader_parameter("time_scale", wave_speed)
	material.set_shader_parameter("height_scale", height_scale)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	material.set_shader_parameter("wave_time", time)

func get_height(world_position: Vector3) -> float:
	var uv_x: float = wrapf(world_position.x / noise_scale + time * wave_speed, 0, 1)
	var uv_y: float = wrapf(world_position.z / noise_scale + time * wave_speed, 0, 1)

	var pixel_pos: Vector2 = Vector2((
		((uv_x * noise.get_width()) + (uv_x * noise2.get_width()) + (uv_x * noise3.get_width())) / 3),
		((uv_x * noise.get_height()) + (uv_x * noise2.get_height()) + (uv_x * noise3.get_height())) / 3)
	return global_position.y + ((noise.get_pixelv(pixel_pos).r + noise2.get_pixelv(pixel_pos).r + noise3.get_pixelv(pixel_pos).r)) * height_scale 


func _on_timer_timeout() -> void:
	var plane: PlaneMesh = self.mesh

	var rand: RandomNumberGenerator = RandomNumberGenerator.new()
	rand.randomize()

	var random_x:float = rand.randf_range(-plane.size.x / 2, plane.size.x / 2)
	var random_z:float = rand.randf_range(-plane.size.y / 2, plane.size.y / 2)

	var new_fish: Flying_fish = FLYING_FISH.instantiate() as RigidBody3D
	add_child(new_fish)
	new_fish.position = Vector3(random_x, 0, random_z)

	if (random_x > 0):
		new_fish.apply_force_direction(Vector3(randf_range(-4, -7),7,0), player, self, shoot_height)
	else:
		new_fish.apply_force_direction(Vector3(randf_range(4, 7),7,0), player, self, shoot_height)

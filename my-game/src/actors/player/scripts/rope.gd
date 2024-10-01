extends Node3D

@onready var point: RigidBody3D = $NodeTemplate
@onready var hookable: Hookable = $"../RigidBody3D/Hookable"
@onready var bobber_mesh: MeshInstance3D = $"../Player/Head/FishingRod/BobberMesh"

var nodes: Array[RigidBody3D]
var springs: Array[Spring]

@onready var cube: MeshInstance3D = $MeshInstance3D
@export var mat: ShaderMaterial

var length: int = 4
@export_category("Mesh")
@export var lenght: int = 10 ## The number of nodes
@export var radial_segments: int
@export var cylSize: float
@export var height:float
@export var mesh: ArrayMesh
var mesh_data: MeshDataTool

@export_category("Rope physics")
@export_range(0, 100) var spring_constant: float = 10.0
@export_range(0, 100) var damping_constant: float = 1
@export_range(0, 10) var max_distance: float = 0.1

var frozen: bool       = false ## boolean to set if the nodes are frozen
var last_update: float = Time.get_unix_time_from_system() ## Time since the nodes got interacted with a colission object


func _ready() -> void:
	spawn_nodes()
	connect_nodes()
	create_rope_mesh()
	for spring: Spring in springs:
		print(spring._to_string())

func _physics_process(_delta: float) -> void:
	for spring: Spring in springs:
		spring.point_one.sleeping = frozen
		spring.point_two.sleeping = frozen
		spring.move()

	set_frozen()
	springs[springs.size()-1].point_two.freeze = true #global_position =bobber_mesh.global_position

	if(hookable.is_hooked):
		springs[0].point_one.global_position = hookable.global_position
	springs[0].tp()

	move_rope()



## Spawns the nodes using the [param lenght] as the number of nodes spawned
func spawn_nodes() -> void:
	for l: int in range(lenght):
		var new_point: RigidBody3D = point.duplicate()
		new_point.freeze = false
		new_point.name = "node %s" % (l+1)
		new_point.global_position += Vector3(l, 0, l)
		nodes.append(new_point)
		add_child(new_point, true)


func move_rope() -> void:
	# you can acces each vertex using the mesh_data.get_vertex(index: int) or mesh_data.set_vertex(index: int, position: Vector3)
	# when you want to commit the changes you have to first remove the old mesh using mesh.clear_surfaces() and then mesh_data.commit_to_surface(mesh)

	mesh.clear_surfaces()
	mesh_data.commit_to_surface(mesh)
	pass


##Will set all the nodes to frozen to reduce processing time.
##This is based on the movement of the player or the time since another collision object collided with the rope
func set_frozen() -> void:
	if Time.get_unix_time_from_system() - last_update > 5:
		frozen = true
	else:
		frozen = false

	var actions: Array[String] = ["forward", "backward", "left", "right"]

	for key: String in actions:
		if Input.is_action_just_pressed(key):
			last_update = Time.get_unix_time_from_system()
			frozen = false


## Will make new springs using the [param nodes] array.
func connect_nodes() -> void:
	for i: int in range(nodes.size()):
		if(i+1 != nodes.size()):
			var spring: Spring = Spring.new(nodes[i], nodes[i+1], spring_constant, damping_constant, max_distance)
			springs.append(spring)

func _on_node_template_body_entered() -> void:
	last_update = Time.get_unix_time_from_system()


func create_rope_mesh() -> void:
	var cylinder_mesh = CylinderMesh.new()
	cylinder_mesh.height = height
	cylinder_mesh.bottom_radius = cylSize
	cylinder_mesh.top_radius = cylSize
	cylinder_mesh.radial_segments = radial_segments
	cylinder_mesh.rings = 5
	var arrayMesh: Array = cylinder_mesh.get_mesh_arrays()

	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrayMesh)
	mesh_data = MeshDataTool.new()
	mesh_data.create_from_surface(mesh, 0)

	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = mesh
	add_child(mesh_instance)

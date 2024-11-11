extends Node3D

@onready var point: RigidBody3D = $NodeTemplate
var bobber_mesh: MeshInstance3D

var nodes: Array[RigidBody3D]
var springs: Array[Spring]

var length: int = 4
@export_category("Mesh")
@export var lenght: int = 10 ## The number of nodes
@export_range(0.01, 0.1, 0.01) var width: float
@export var material: Material
var mesh: SurfaceTool = SurfaceTool.new()
var meshInstance: MeshInstance3D = MeshInstance3D.new()

@export_category("Rope physics")
@export_range(50, 1000, 10, "or_greater") var spring_constant: float = 800
@export_range(0, 100, 1.0) var damping_constant: float = 5
@export_range(0, 10, 0.01) var max_distance: float = .1

var frozen: bool = false ## boolean to set if the nodes are frozen
var last_update: float = Time.get_unix_time_from_system() ## Time since the nodes got interacted with a colission object

func _ready() -> void:


	spawn_nodes()
	connect_nodes()

	#for spring: Spring in springs:
		#print_debug(spring._to_string())

func _physics_process(_delta: float) -> void:
	if bobber_mesh != null:
		for spring: Spring in springs:
			spring.point_one.sleeping = frozen
			spring.point_two.sleeping = frozen
			spring.move()

		set_frozen()
		springs[springs.size()-1].point_two.global_position = bobber_mesh.global_position
		springs[springs.size()-1].point_two.sleeping = true
		#if(hookable.is_hooked):
			#springs[0].point_one.global_position = hookable.global_position
			#springs[0].point_one.sleeping = true
		var bobber: Bobber = get_tree().get_first_node_in_group("bobber")
		if bobber != null:
			springs[0].point_one.global_position = bobber.global_position
			springs[0].point_one.sleeping = true
		#if get_tree().current_scene.get_child_count() == 4:
			#springs[0].point_one.global_position = get_tree().current_scene.get_child(3).global_position
			#springs[0].point_one.sleeping = true

		create_rope_mesh()



## Spawns the nodes using the [param lenght] as the number of nodes spawned
## @experimental: This should definitly be changed. Might want calculate where the rope should go and spawn it that way. for  now most of the rope spawns inside of the player
## and just glitches out trying to get out of the collision object
func spawn_nodes() -> void:
	for l: int in range(lenght):
		var new_point: RigidBody3D = point.duplicate()
		new_point.freeze = false
		new_point.name = "node %s" % (l+1)
		nodes.append(new_point)
		add_child(new_point, true)



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

## @experimental: This might not be needed i implemented this for performance benefits while nothing happens to the rope
## This will check if anything interacts with the balls inside the line. If it does it will update the value that checks if the line should be frozen or not
func _on_node_template_body_entered(_body: Node) -> void:
	last_update = Time.get_unix_time_from_system()

## This function will create the mesh for the rope.
## The mesh is a [enum Mesh.PRIMITIVE_TRIANGLE_STRIP]
## each ball will create 4 verteces 2 at the first node and 2 at the second node. The perpendicular points are calculated using the [method Vector3.cross] product of the direction and [enum Vector3.Down]
func create_rope_mesh() -> void:
	mesh.clear()
	mesh.begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
	for spring: Spring in springs:
		var point_one: Vector3 = spring.point_one.position
		var point_two: Vector3 = spring.point_two.position

		var dir: Vector3 = (point_one - point_two).normalized()
		var perpendicular: Vector3 = dir.cross(Vector3.DOWN).normalized() * width

		mesh.add_vertex(point_one + perpendicular)
		mesh.add_vertex(point_one - perpendicular)
		mesh.add_vertex(point_two + perpendicular)
		mesh.add_vertex(point_two - perpendicular)

	#mesh.generate_normals(true)
	#mesh.generate_tangents()
	mesh.set_material(material)
	meshInstance.mesh = mesh.commit()

	if meshInstance.get_parent():
		meshInstance.reparent(self)
	else:
		add_child(meshInstance)
	#meshInstance.reparent(self)
	#add_child(meshInstance)

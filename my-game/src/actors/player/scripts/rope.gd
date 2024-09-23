extends Node

@onready var point: RigidBody3D = $NodeTemplate
@onready var hookable: Hookable = $"../RigidBody3D/Hookable"
@onready var bobber_mesh: MeshInstance3D = $"../Player/Head/FishingRod/BobberMesh"




var nodes: Array[RigidBody3D]
var springs: Array[Spring]

@export var lenght: int = 20
@export_range(0, 100) var spring_constant: float = 10.0
@export_range(0, 100) var damping_constant: float = 1
@export_range(0, 10) var max_distance: float = 0.1

var frozen: bool = false
var last_update: float = Time.get_unix_time_from_system()

var actions: Array[String] = ["forward", "backward", "left", "right"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_nodes()
	connect_nodes()
	for spring in springs:
		print(spring.to_string())
	

	
	
func _physics_process(delta: float) -> void:
	for spring in springs:
		spring.point_one.sleeping = frozen
		spring.point_two.sleeping = frozen
		spring.move()
		
	set_frozen()
	springs[springs.size()-1].point_two.global_position =bobber_mesh.global_position
			
	if(hookable.is_hooked):
		springs[0].point_one.global_position = hookable.global_position
	springs[0].tp()
		
func spawn_nodes():
	for l in range(lenght):
		var new_point: RigidBody3D = point.duplicate()
		new_point.freeze = false
		new_point.name = "node %s" % (l+1)
		new_point.global_position += Vector3(l, l,l)
		nodes.append(new_point)
		add_child(new_point, true)
	
		
func set_frozen():
	if Time.get_unix_time_from_system() - last_update > 5:
		frozen = true
	else:
		frozen = false
		
	for key in actions:
		if Input.is_action_just_pressed(key):
			last_update = Time.get_unix_time_from_system()
			frozen = false
	
	
func connect_nodes():
	for i in range(nodes.size()):
		if(i+1 != nodes.size()):
			var spring = Spring.new(nodes[i], nodes[i+1], spring_constant,  damping_constant, max_distance)
			springs.append(spring)
		
func _on_node_template_body_entered(body: Node) -> void:
	last_update = Time.get_unix_time_from_system()
	


	

extends Node

@onready var point: RigidBody3D = $NodeTemplate
@export var lenght: int = 20
@onready var player: Player = $"../Player"
var nodes: Array[RigidBody3D]
var springs: Array[Spring]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_nodes()
	connect_nodes()
	for spring in springs:
		print(spring.to_string())
	
	
func _process(delta: float) -> void:
	print(Performance.get_monitor(Performance.TIME_PROCESS))
	
func _physics_process(delta: float) -> void:
	
	for spring in springs:
		spring.move()
		
	springs[0].tp()
		
func spawn_nodes():
	for l in range(lenght):
		var new_point: RigidBody3D = point.duplicate()
		new_point.freeze = false
		new_point.name = "node %s" % (l+1)
		new_point.global_position += Vector3(l, l,l)
		nodes.append(new_point)
		add_child(new_point, true)
	
	nodes[0].freeze =true
	
	
func connect_nodes():
	
	for i in range(nodes.size()):
		if(i+1 != nodes.size()):
			var spring = Spring.new(nodes[i], nodes[i+1])
			springs.append(spring)
		

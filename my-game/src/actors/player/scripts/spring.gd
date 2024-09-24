class_name Spring

var point_one: RigidBody3D
var point_two: RigidBody3D
## Sets the strenght of the spring[br]
## A higher number is a stronger spring
var spring_constant: float = 100.0
## Sets the dampening the springs gets[br]
## A higher number means that the spring moves slower but more controlled
var damping_constant: float = 1.0
## The maximum distance between [member point_one] and [member point_two]
var max_distance: float = 0.1

func _init(point_one: RigidBody3D, point_two: RigidBody3D, spring_constant: float, damping_constant: float, max_distance: float) -> void:
	self.point_one = point_one
	self.point_two = point_two
	self.damping_constant = damping_constant
	self.spring_constant = spring_constant
	self.max_distance = max_distance

## Applies the forces to the nodes 
func move() -> void:
	var distance_between: float = point_one.global_position.distance_to(point_two.global_position)
	var displacement: Vector3 = point_two.global_position - point_one.global_position
	var spring_force: Vector3 = displacement.normalized() * (distance_between - max_distance) * spring_constant
	var damping_force: Vector3 = -point_one.linear_velocity * damping_constant


	point_one.apply_central_force(spring_force + damping_force)
	point_two.apply_central_force(-spring_force + damping_force)
		
## @experimental: This method is for testing purposses[br]
## This function tps a node using the "move_block" and "move_block2" action
func tp():
	if Input.is_action_just_pressed("move_block"):
		point_one.global_position += Vector3(0,2,2)
	if Input.is_action_just_pressed("move_block2"):
		point_one.global_position += Vector3(0,0,-2)
		

func _to_string() -> String:
	return "One: %s, Two: %s" % [point_one, point_two]

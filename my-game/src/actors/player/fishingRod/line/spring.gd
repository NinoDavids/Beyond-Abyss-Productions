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

func _init(point_1: RigidBody3D, point_2: RigidBody3D, spring_const: float, damping_const: float, max_dist: float) -> void:
	self.point_one = point_1
	self.point_two = point_2
	self.damping_constant = damping_const
	self.spring_constant = spring_const
	self.max_distance = max_dist

## Applies the forces to the nodes
func move() -> void:
	var distance_between: float = point_one.global_position.distance_to(point_two.global_position)
	var displacement: Vector3 = point_two.global_position - point_one.global_position
	var correction_force: Vector3 = displacement.normalized() * (distance_between - max_distance) * spring_constant
	var damping_force: Vector3 = -point_two.linear_velocity * damping_constant


	point_one.apply_central_force(correction_force)
	point_two.apply_central_force(-correction_force + damping_force)

func _to_string() -> String:
	return "One: %s, Two: %s" % [point_one, point_two]

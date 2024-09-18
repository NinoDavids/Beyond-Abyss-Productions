extends Node3D
class_name FishingRod

@onready var rope_mesh: MeshInstance3D = $RopePoint/RopeMesh
@onready var rope_point: Node3D = $RopePoint
var bobber: Bobber

func _physics_process(_delta: float) -> void:
	if rope_mesh.visible:
		set_rope_size()

func set_rope_size() -> void:
	var mesh: ImmediateMesh = ImmediateMesh.new()
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	print(rope_point.global_transform.origin)
	mesh.surface_add_vertex(rope_point.global_transform.origin)
	mesh.surface_add_vertex(bobber.global_transform.origin)
	mesh.surface_end()
	rope_mesh.mesh = mesh
	#var size: Vector3 = rope_point.global_transform.origin + bobber.global_transform.origin
	#var middle: Vector3 = size / 2
	#rope_mesh.global_transform.origin = middle
	#rope_mesh.mesh.height = max(size.x, size.y, size.z)
	#rope_mesh.look_at(rope_point.global_transform.origin)

func set_active(active: bool) -> void:
	rope_mesh.visible = active

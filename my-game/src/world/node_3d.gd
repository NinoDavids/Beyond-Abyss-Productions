extends Node3D


@export var mesh: ArrayMesh
var mesh_data: MeshDataTool
@onready var cube: MeshInstance3D = $MeshInstance3D
@export var mat: ShaderMaterial
var ring_segments: Dictionary = {}

@export var length: int
@export var radial_segments: int
@export var cylSize: float
@export var height:float


func _ready() -> void:
	pass
	create_rope_mesh()
	var count: float = mesh_data.get_vertex_count()
	print(count)

#
	for i in range(count):

		var dub: MeshInstance3D = cube.duplicate()
		var new_mat = mat.duplicate()
		new_mat.set_shader_parameter("Color", Vector3(i/count, 0,0))
		dub.set_surface_override_material(0, new_mat)
		add_child(dub)
		dub.name = "%s" % (i)
		dub.position = mesh_data.get_vertex(i)
		print(mesh_data.get_vertex(i))




func create_rope_mesh() -> void:
	var cylinder_mesh = CylinderMesh.new()
	cylinder_mesh.height = height
	cylinder_mesh.bottom_radius = cylSize
	cylinder_mesh.top_radius = cylSize
	cylinder_mesh.radial_segments = radial_segments
	cylinder_mesh.rings = length -2
	var arrayMesh: Array = cylinder_mesh.get_mesh_arrays()

	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrayMesh)
	mesh_data = MeshDataTool.new()
	mesh_data.create_from_surface(mesh, 0)

	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = mesh
	add_child(mesh_instance)

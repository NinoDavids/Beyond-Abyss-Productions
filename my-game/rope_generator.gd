extends MeshInstance3D

@export var material: Material

func _ready():
	# Begin draw.
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES)


	mesh.surface_set_normal(Vector3(0, 0, 1))
	mesh.surface_set_uv(Vector2(0, 0))
	mesh.surface_add_vertex(Vector3(-1, -1, 0))

	mesh.surface_set_normal(Vector3(0, 0, 1))
	mesh.surface_set_uv(Vector2(0, 1))
	mesh.surface_add_vertex(Vector3(-1, 1, 0))

	mesh.surface_set_normal(Vector3(0, 0, 1))
	mesh.surface_set_uv(Vector2(1, 1))
	mesh.surface_add_vertex(Vector3(1, 1, 0))

	mesh.surface_set_normal(Vector3(0, 0, 1))
	mesh.surface_set_uv(Vector2(0, 1))
	mesh.surface_add_vertex(Vector3(-1, -1, 0))

	mesh.surface_set_normal(Vector3(0, 0, 1))
	mesh.surface_set_uv(Vector2(0, 1))
	mesh.surface_add_vertex(Vector3(1, 1, 0))

	mesh.surface_set_normal(Vector3(0, 0, 1))
	mesh.surface_set_uv(Vector2(1, 0))
	mesh.surface_add_vertex(Vector3(1, -1, 0))

	#mesh.set_surface_override_material(0,material)


	mesh.surface_end()

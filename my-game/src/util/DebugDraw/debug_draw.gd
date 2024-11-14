extends Node

@onready var draw_debug: MeshInstance3D = $MeshInstance3D

func _physics_process(_delta: float) -> void:
	if draw_debug.mesh is ImmediateMesh:
		draw_debug.mesh.clear_surfaces()

func draw_line(point_a: Vector3, point_b: Vector3, color: Color = Color.RED) -> void:
	if point_a.is_equal_approx(point_b):
		return

	if draw_debug.mesh is ImmediateMesh:
		draw_debug.mesh.surface_begin(Mesh.PRIMITIVE_LINES)
		draw_debug.mesh.surface_set_color(color)

		draw_debug.mesh.surface_add_vertex(point_a)
		draw_debug.mesh.surface_add_vertex(point_b)

		draw_debug.mesh.surface_end()

func draw_line_relative(point_a: Vector3, point_b: Vector3, color: Color = Color.RED) -> void:
	draw_line(point_a, point_a+point_b, color)

func draw_line_relative_thickpointy(pointA: Vector3, pointB: Vector3, thickness: float = 2.0, color: Color = Color.BLACK) -> void:
	pointB = pointA + pointB

	if pointA.is_equal_approx(pointB):
		return

	if draw_debug.mesh is ImmediateMesh:
		draw_debug.mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
		draw_debug.mesh.surface_set_color(color)

		#var material: StandardMaterial3D = StandardMaterial3D.new()
		#material.vertex_color_use_as_albedo = true
		#material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		#material.albedo_color = color
		#draw_debug.material_override = material

		var scale_factor: float = 100.0

		var dir: Vector3 = pointA.direction_to(pointB)
		var EPISILON: float = 0.00001

		var normal: Vector3 = Vector3(-dir.y, dir.x, 0).normalized() \
			if (abs(dir.x) + abs(dir.y) > EPISILON) \
			else Vector3(0, -dir.z, dir.y).normalized()
		normal *= thickness / scale_factor

		var verticies_strip_order: Array[int] = [4, 5, 0, 1, 2, 5, 6, 4, 7, 0, 3, 2, 7, 6]
		var localB: Vector3 = (pointB-pointA)

		for v: int in range(14):
			var vertex: Vector3 = normal if \
				verticies_strip_order[v] < 4 else \
				normal + localB
			var final_vert: Vector3 = vertex.rotated(dir,
				PI * (0.5 * (verticies_strip_order[v] % 4) + 0.25))
			final_vert += pointA
			draw_debug.mesh.surface_add_vertex(final_vert)
		draw_debug.mesh.surface_end()

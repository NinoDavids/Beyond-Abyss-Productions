extends MeshInstance3D

@export var timer:Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera = get_viewport().get_camera_3d()





	var distance = transform.origin.distance_to(camera.global_transform.origin)
	print(distance)

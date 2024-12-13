extends CanvasModulate

@export var gradient: GradientTexture1D

var time:float = 0.0

@export var startTime: float = 0.0
@export var endTime: float = 0.0


func _process(delta: float) -> void:
	time += delta
	var temp = (sin(time - PI / 2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(temp)

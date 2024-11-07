extends Area3D
class_name Hookable

var is_hooked: bool = false
var bobber: Bobber

## A function that gets called as soon as the [Hookable] [member is_hooked] AND the [Player] [kbd]scroll wheel down[/kbd].
func reel_in() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if bobber:
		place_bobber()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reel_hook") and is_hooked:
		reel_in()

func _on_body_entered(body: Node3D) -> void:
	if body is Bobber:
		is_hooked = true
		bobber = body
		place_bobber()
		body.tree_exited.connect(remove_bobber)


## Places the [member bobber] in the center of the [Hookable].
func place_bobber() -> void:
	bobber.set_hooked(global_position)

## Removes the [member bobber] from the [Hookable].
func remove_bobber() -> void:
	is_hooked = false
	bobber = null

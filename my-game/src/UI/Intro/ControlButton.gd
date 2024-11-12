extends Control

@onready var next_button: Button = %Button
@export var start_level: PackedScene = preload("res://src/world/Level/Level.tscn") 


func _on_next_button_button_down():
	get_tree().change_scene_to_packed(start_level)
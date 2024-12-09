class_name InGameMenu 
extends Control

@onready var options_menu: OptionsMenu = $"%OptionsMenu"
@onready var main_menu_path: String = "res://src/world/Levels/Level1/Level1.tscn"

func _on_options_button_pressed() -> void:
	if options_menu.visible:
		options_menu.visible = false
	if !options_menu.visible:
		options_menu.visible = true

func _on_start_button_pressed() -> void:
	get_tree().paused = false
	self.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	self.hide()
	get_tree().change_scene_to_file(main_menu_path)

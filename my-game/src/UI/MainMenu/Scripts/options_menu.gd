class_name OptionsMenu
extends Control

@onready var exit_button: Button = %exit_button



signal exit_options_menu

func _ready():
	exit_button.button_down.connect(on_exit_pressed)

func on_exit_pressed() -> void: 
	exit_options_menu.emit()

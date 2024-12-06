class_name MainMenu 
extends Control

@onready var start_button: Button = %Start_button
@onready var exit_button: Button = %Exit_button 
@onready var options_button: Button = %Options_button 
@onready var options_menu: OptionsMenu = %OptionsMenu
@export var start_level: PackedScene

func _ready() -> void :
	handeling_signals()

func on_options_pressed() ->void: 
	if(options_menu.visible):
		options_menu.visible = false
	else:
		options_menu.visible = false
		
func on_exit_pressed() -> void:
	get_tree().quit() 
	
func on_start_pressed() -> void: 
	get_tree().change_scene_to_packed(start_level)
	
func handeling_signals() -> void: 
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	options_button.button_down.connect(on_options_pressed)

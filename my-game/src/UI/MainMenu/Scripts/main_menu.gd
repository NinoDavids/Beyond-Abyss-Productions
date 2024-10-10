class_name MainMenu 
extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Start_button 
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_button 
@onready var options_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Options_button 
@onready var options_menu: OptionsMenu = $OptionsMenu
@onready var margin_container: MarginContainer = $MarginContainer
@export var start_level: PackedScene = preload("res://src/world/World.tscn") 


func _ready() -> void :
	handeling_signals()

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_options_pressed() ->void: 
	margin_container.visible = false 
	options_menu.set_process(true)
	options_menu.visible = true

func on_exit_pressed() -> void:
	get_tree().quit() 

func on_exit_options_menu() -> void: 
	margin_container.visible = true 
	options_menu.visible = false 

func handeling_signals() -> void: 
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	options_button.button_down.connect(on_options_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
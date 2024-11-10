class_name MainMenu 
extends Control

@onready var start_button: Button = %Start_button
@onready var exit_button: Button = %Exit_button 
@onready var options_button: Button = %Options_button 
@onready var options_menu: OptionsMenu = %OptionsMenu
@onready var margin_container: MarginContainer = $MarginContainer
@onready var start_level: PackedScene = preload("res://src/world/Level/Level.tscn") 
@onready var play_container: VBoxContainer = $PlayContainer

@onready var playtest_level: PackedScene = preload("res://src/Playtest 1/Level 1/level1.tscn")
@onready var world_level: PackedScene = preload("res://src/world/Levels/Level1/Level1.tscn")

func _ready() -> void :
	handeling_signals()

func on_start_pressed() -> void:
	margin_container.visible = false
	play_container.visible = true

func on_options_pressed() ->void: 
	margin_container.visible = false 
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

func _on_puzzle_button_pressed() -> void:
	get_tree().change_scene_to_packed(playtest_level)

func _on_env_button_pressed() -> void:
	get_tree().change_scene_to_packed(world_level)

func _on_back_button_pressed() -> void:
	margin_container.visible = true
	play_container.visible = false

class_name OptionsMenu
extends Control

@onready var exit_button: Button = %exit_button
@onready var sens_slider: HSlider = $MarginContainer/VBoxContainer/HBoxContainer2/SensSlider
@onready var invert_button: CheckBox = $MarginContainer/VBoxContainer/HBoxContainer/InvertButton

signal exit_options_menu

func _ready() -> void:
	exit_button.button_down.connect(on_exit_pressed)
	update_buttons()

func update_buttons() -> void:
	sens_slider.value = SettingsManager.get_sensitivity()
	invert_button.button_pressed = SettingsManager.get_inverted_y()

func on_exit_pressed() -> void: 
	exit_options_menu.emit()


func _on_invert_button_toggled(toggled_on: bool) -> void:
	SettingsManager.settings.inverted_y = toggled_on
	ResourceSaver.save(SettingsManager.settings)


func _on_sens_slider_drag_ended(_value_changed: bool) -> void:
	SettingsManager.settings.sensitivity = sens_slider.value
	ResourceSaver.save(SettingsManager.settings)


func _on_reset_settings_pressed() -> void:
	SettingsManager.settings.inverted_y = false
	SettingsManager.settings.sensitivity = 0.25
	ResourceSaver.save(SettingsManager.settings)
	update_buttons()

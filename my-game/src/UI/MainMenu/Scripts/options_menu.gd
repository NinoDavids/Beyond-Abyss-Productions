class_name OptionsMenu
extends Control

@export var masterVolume: HSlider
@export var musicVolume: HSlider
@export var SFXVolume: HSlider

@export var invert_button: CheckBox
@export var resetControls: Button
@export var back_button: Button

signal exit_options_menu

func _ready() -> void:
	back_button.button_down.connect(on_back_pressed)
	update_buttons()

func update_buttons() -> void:
	masterVolume.value = SettingsManager.get_sensitivity()
	musicVolume.value = SettingsManager.get_sensitivity()
	SFXVolume.value = SettingsManager.get_sensitivity()

	invert_button.button_pressed = SettingsManager.get_inverted_y()

func on_back_pressed() -> void: 
	exit_options_menu.emit()

func _on_invert_button_toggled(toggled_on: bool) -> void:
	SettingsManager.settings.inverted_y = toggled_on
	ResourceSaver.save(SettingsManager.settings)

func _on_master_slider_drag_ended(_value_changed: bool) -> void:
	SettingsManager.settings.masterVolume = masterVolume.value
	ResourceSaver.save(SettingsManager.settings)
	
func _on_music_slider_drag_ended(_value_changed: bool) -> void:
	SettingsManager.settings.musicVolume = musicVolume.value
	ResourceSaver.save(SettingsManager.settings)
	
func _on_sfx_slider_drag_ended(_value_changed: bool) -> void:
	SettingsManager.settings.SFXVolume = SFXVolume.value
	ResourceSaver.save(SettingsManager.settings)


func _on_reset_settings_pressed() -> void:
	SettingsManager.settings.inverted_y = false
	SettingsManager.settings.sensitivity = 0.25
	ResourceSaver.save(SettingsManager.settings)
	update_buttons()

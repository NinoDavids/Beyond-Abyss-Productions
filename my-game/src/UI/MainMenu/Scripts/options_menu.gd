class_name OptionsMenu
extends Control

@export var masterVolume: HSlider
@export var musicVolume: HSlider
@export var SFXVolume: HSlider

@export var invert_button: CheckBox
@export var resetControls: Button
@export var back_button: Button

func _ready() -> void:
	back_button.button_down.connect(on_back_pressed)
	update_buttons()

func update_buttons() -> void:
	masterVolume.value = SettingsManager.get_masterVolume()
	musicVolume.value = SettingsManager.get_musicVolume()
	SFXVolume.value = SettingsManager.get_SFXVolume()

	invert_button.button_pressed = SettingsManager.get_inverted_y()

func on_back_pressed() -> void: 
	self.visible = false

func _on_invert_button_toggled(toggled_on: bool) -> void:
	SettingsManager.settings.inverted_y = toggled_on
	ResourceSaver.save(SettingsManager.settings)

func _on_master_slider_drag_ended(_value_changed: bool) -> void:
	SettingsManager.set_masterVolume(masterVolume.value)
	ResourceSaver.save(SettingsManager.settings)
	
func _on_music_slider_drag_ended(_value_changed: bool) -> void:
	SettingsManager.set_musicVolume(musicVolume.value)
	ResourceSaver.save(SettingsManager.settings)
	
func _on_sfx_slider_drag_ended(_value_changed: bool) -> void:
	SettingsManager.set_SFXVolume(SFXVolume.value) 
	ResourceSaver.save(SettingsManager.settings)


func _on_reset_settings_pressed() -> void:
	SettingsManager.settings.inverted_y = false
	SettingsManager.settings.sensitivity = 0.25
	SettingsManager.settings.masterVolume = 1.0
	SettingsManager.settings.musicVolume = 1.0
	SettingsManager.settings.SFXVolume = 1.0
	ResourceSaver.save(SettingsManager.settings)
	update_buttons()

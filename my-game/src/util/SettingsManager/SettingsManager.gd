extends Node

@onready var settings: SettingsData = preload("res://src/util/SettingsManager/Settings/PlayerSettings.tres") as SettingsData

func get_inverted_y() -> bool:
	return settings.inverted_y

func get_inverted_y_float() -> float:
	if settings.inverted_y:
		return -1
	return 1

func get_masterVolume() -> float:
	return settings.masterVolume
	
func get_musicVolume() -> float:
	return settings.musicVolume
	
func get_SFXVolume() -> float:
	return settings.SFXVolume

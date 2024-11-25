extends Node3D

var AppID: String = "2719760"

@onready var player: Player = $Player
var time_elapsed: float

func _init() -> void:
	OS.set_environment("SteamAppID", AppID)
	OS.set_environment("SteamGameID", AppID)

func _ready() -> void:
	Steam.steamInit()
	var _isRunning: bool = Steam.isSteamRunning()
	setAchievement("ACH_STARTGAME")
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)

func setAchievement(ach: String) -> void:
	var status: Dictionary = Steam.getAchievement(ach)
	if status["achieved"]:
		return
	Steam.setAchievement(ach)

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("quitEditor")):
		get_tree().quit();

func _process(delta: float) -> void:
	time_elapsed += delta
	var time_to_int: int = int(time_elapsed)

	if time_to_int >= 3:
		get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)
		time_elapsed = 0.0

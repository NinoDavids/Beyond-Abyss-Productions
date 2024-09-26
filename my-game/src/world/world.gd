extends Node3D

var AppID = "2719760"

func _init() -> void:
	OS.set_environment("SteamAppID", AppID)
	OS.set_environment("SteamGameID", AppID)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Steam.steamInit()
	var isRunning = Steam.isSteamRunning()
	setAchievement("ACH_STARTGAME")

func setAchievement(ach):
	var status = Steam.getAchievement(ach)
	if status["achieved"]:
		return
	Steam.setAchievement(ach)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

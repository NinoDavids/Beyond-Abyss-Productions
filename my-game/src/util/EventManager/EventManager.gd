extends Node

@warning_ignore("unused_signal")
signal player_damaged()
@warning_ignore("unused_signal")
signal player_regenerating()
@warning_ignore("unused_signal")
signal anim_hookable_finished()
@warning_ignore("unused_signal")
signal player_died()
@warning_ignore("unused_signal")
signal player_respawned()

signal audio_playsound(sound_name: String)
signal audio_stopsound(sound_name: String)
signal audio_stop_all_sounds()
signal audio_stop_all_sounds_in_bus(bus: AudioBus.BusTypes)

func play_sound(sound_name: String) -> void:
    emit_signal("audio_playsound", sound_name)
func stop_sound(sound_name: String) -> void:
    emit_signal("audio_stopsound", sound_name)
func stop_all_sounds() -> void:
    emit_signal("audio_stop_all_sounds")
func stop_all_sounds_in_bus(bus: AudioBus.BusTypes) -> void:
    emit_signal("audio_stop_all_sounds_in_bus", bus)
# endregion
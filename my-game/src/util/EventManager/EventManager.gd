extends Node

signal player_damaged()
signal player_regenerating()

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
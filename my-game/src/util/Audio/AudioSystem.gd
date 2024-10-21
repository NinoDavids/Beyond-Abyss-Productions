class_name AudioSystem
extends Node3D

@export var Sounds: Array[SoundObject]

func _ready() -> void:
	EventManager.connect("audio_playsound", Callable(self, "playsound"))
	EventManager.connect("audio_stopsound", Callable(self, "playsound"))
	EventManager.connect("audio_stop_all_sounds", Callable(self, "stop_all_sounds"))
	EventManager.connect("audio_stop_all_sounds_in_bus", Callable(self, "stop_all_sounds_in_bus"))
	_update_sounds()

func _update_sounds() -> void:
	for sound: SoundObject in Sounds:
		# Ensure the sound has a valid name
		if (sound.clip_name.is_empty() and sound.clip != null):
			# If someone forgot to set the clip name, set it to the file name
			sound.clip_name = sound.clip.resource_path.get_file().get_basename()

		# # Load settings into the AudioStreamPlayer
		if sound.source == null:
			sound.source = AudioStreamPlayer3DWithLoop.new()
			self.add_child(sound.source)
		
		sound.source.name = sound.source.get_class() + "-" + sound.clip_name
		sound.source.stream = sound.clip
		sound.source.bus = AudioBus.convert_bus_type(sound.audio_bus)
		sound.source.volume_db = sound.volume_db
		sound.source.pitch_scale = sound.pitch_scale
		sound.source.loop = sound.loop
		sound.source.autoplay = sound.autoplay

		# Play the startup sounds
		if sound.autoplay:
			playsound(sound.clip_name)

func playsound(sound_name: String, _fade_duration=0) -> void:
	for sound: SoundObject in Sounds:
		if sound.clip_name == sound_name:
			sound.source.play()

func stopsound(sound_name: String, _fade_duration=0) -> void:
	for sound: SoundObject in Sounds:
		if sound.clip_name == sound_name:
			sound.source.stop()

func stop_all_sounds() -> void:
	for sound: SoundObject in Sounds:
		stopsound(sound.clip_name)

func stop_all_sounds_in_bus(type: AudioBus.BusTypes) -> void:
	for sound: SoundObject in Sounds:
		if (sound.audio_bus == type):
			stopsound(sound.clip_name)

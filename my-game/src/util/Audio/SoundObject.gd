class_name SoundObject
extends Resource

@export var clip_name: String
@export var clip: AudioStream
@export var audio_bus: AudioBus.BusTypes
@export var volume_db: float = 0.0
@export var pitch_scale: float = 1.0
@export var autoplay: bool = false
# Contains the assigned AudioStreamPlayer node. Should be assigned from script.
var source: AudioStreamPlayer3D
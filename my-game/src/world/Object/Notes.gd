@tool
extends RigidBody3D

@export var title: String
@export var description: String
@export var titleObject: Label3D
@export var descriptionObject: Label3D
@export var setNoteText: bool = false : set = set_note

func set_note(new_value: bool) -> void:
	loadNoteText()

func loadNoteText() -> void:
	titleObject.text = title
	descriptionObject.text = description

func _ready() -> void:
	add_to_group("Notes")
	loadNoteText()
	
func interact() -> void:
	print_debug("test")

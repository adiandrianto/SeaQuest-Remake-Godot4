extends Node2D

@onready var audio_stream_player = $"../AudioStreamPlayer"
@onready var animation_player = $"../AnimationPlayer"
@export var ui_order = 1
const EMPTY_TEXTURE = preload("res://user_interface/people-count/person_empty_ui.png")
const FULL_TEXTURE = preload("res://user_interface/people-count/person_ui.png")

func _ready():
	#animation_player.play("default")
	GameEvent.connect("person_updated", Callable(self, "_update"))
	GameEvent.connect("full_crew", Callable(self, "on_full_crew"))

func on_full_crew():
	animation_player.play("unload")
	audio_stream_player.play()

func _update():
	if Global.total_person_saved >= ui_order:
		get_child(0).texture = FULL_TEXTURE
	else :
		get_child(0).texture = EMPTY_TEXTURE
	
	
	

extends Node2D

@export var ui_order = 1
const EMPTY_TEXTURE = preload("res://user_interface/people-count/person_empty_ui.png")
const FULL_TEXTURE = preload("res://user_interface/people-count/person_ui.png")

func _ready():
	GameEvent.connect("person_updated", Callable(self, "_update"))

func _update():
	if Global.total_person_saved >= ui_order:
		get_child(0).texture = FULL_TEXTURE
	else :
		get_child(0).texture = EMPTY_TEXTURE
	
	
	

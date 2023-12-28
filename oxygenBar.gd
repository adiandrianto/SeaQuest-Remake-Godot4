extends Node2D
@onready var oxygen_bar = $oxygenBar
@onready var animation_player = $AnimationPlayer

func _process(delta):
	oxygen_bar.value = Global.oxygen_level
	if round(Global.oxygen_level) == 25 :
		animation_player.play("alert")

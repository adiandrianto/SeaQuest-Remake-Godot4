extends Area2D

const PERSON_SPEED = 25
const death_sound = preload("res://person/person_death.ogg")
const saved_sound = preload("res://person/saving_person.ogg")
var vel = Vector2(1,0)
var state = "default"
@onready var sprite = %AnimatedSprite2D

func _ready():
	GameEvent.connect("pause_enemies",Callable(self, "on_pause"))
	
func _on_area_entered(area):
	if area.is_in_group("player") && Global.total_person_saved < 7:
		Global.increased_person_saved()
		AudioManager.play_audio(saved_sound)
		queue_free()
		
	if area.is_in_group("bullet"):
		AudioManager.play_audio(death_sound)
		area.queue_free()
		queue_free()

func _process(_delta):
	if global_position.x < Global.MIN_BBOX_X or global_position.x > Global.MAX_BBOX_X:
		queue_free()
		
func _physics_process(delta):
	if state == "default" :
		global_position += vel * delta * PERSON_SPEED

func flip_direction():
	vel = -vel
	%AnimatedSprite2D.flip_h = !%AnimatedSprite2D.flip_h
	
func on_pause(pause):
	if pause :
		state = "paused"
		sprite.stop()
	else :
		sprite.play()
		state = "default"

extends Area2D

const PERSON_SPEED = 25
var vel = Vector2(1,0)

func _on_area_entered(area):
	if area.is_in_group("player"):
		Global.increased_person_saved()
		queue_free()

func _physics_process(delta):
	global_position += vel * delta * PERSON_SPEED

func flip_direction():
	vel = -vel
	%AnimatedSprite2D.flip_h = !%AnimatedSprite2D.flip_h

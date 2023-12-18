extends Area2D

const SHARK_SPEED = 40
const MOVE_FREQ = 0.15
const MOVE_AMP = 0.5
var vel = Vector2(1,0)
@onready var sprite = $sprite
@onready var timer = $Timer

func _physics_process(delta):
	vel.y = sin(global_position.x * MOVE_FREQ) * MOVE_AMP
	global_position += vel * SHARK_SPEED * delta

func _on_area_entered(area):
	if area.is_in_group("bullet"):
		area.queue_free()
		queue_free()
		#sprite.play("dead")
		timer.start()
		
func flip_direction():
	vel = -vel
	sprite.flip_h = !sprite.flip_h
	
func _on_timer_timeout():
	sprite.play("default")

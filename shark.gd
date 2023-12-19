extends Area2D

const SHARK_SPEED = 40
const MOVE_FREQ = 0.15
const MOVE_AMP = 0.5
var vel = Vector2(1,0)
@onready var sprite = $sprite
@onready var timer = $Timer

func _process(delta):
	if global_position.x < Global.MIN_BBOX_X or global_position.x > Global.MAX_BBOX_X:
		queue_free()
		
func _physics_process(delta):
	vel.y = sin(global_position.x * MOVE_FREQ) * MOVE_AMP
	global_position += vel * SHARK_SPEED * delta

func _on_area_entered(area):
	if area.is_in_group("bullet"):
		Global.increased_points(50)
		GameEvent.emit_signal("points_updated")
		queue_free()
		
		timer.start()
	if area.is_in_group("player"):
		GameEvent.emit_signal("game_over")
		
func flip_direction():
	vel = -vel
	sprite.flip_h = !sprite.flip_h
	
func _on_timer_timeout():
	sprite.play("default")

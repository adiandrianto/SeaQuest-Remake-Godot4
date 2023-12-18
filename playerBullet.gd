extends Area2D

const BULLET_SPEED = 300
var vel = Vector2(1, 0)
@onready var sprite = $sprite

func _physics_process(delta):
	global_position += vel * BULLET_SPEED * delta

func _ready():
	rotation_degrees = randf_range(-4, 4)
	vel = vel.rotated(rotation)

func flip_direction():
	vel = -vel
	sprite.flip_h = !sprite.flip_h
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

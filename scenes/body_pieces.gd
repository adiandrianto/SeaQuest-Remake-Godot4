extends Sprite2D

var rot_speed = 50
var move_speed: float = 100.0
var vel: Vector2 = Vector2(1,0)
@onready var animation_player = $AnimationPlayer

func _ready():
	vel = vel.rotated(randf_range(0, TAU))
	rot_speed = randf_range(-60, 60)
	
func _physics_process(delta):
	global_position += vel * move_speed * delta
	rotation_degrees += rot_speed * delta
	move_speed = lerp(move_speed,0.0 , delta*6)
	animation_player.play("destroy")

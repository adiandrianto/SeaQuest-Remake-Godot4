extends Camera2D

@onready var player = %player
const MIN_Y = 0
const MAX_Y = 100
var camera_offset = Vector2(0, -70)

func _process(delta):
	var target_y = player.position.y + camera_offset.y
	var current_y = position.y
	# Smoothly move the camera towards the target Y position
	var lerped_y = lerp(current_y, target_y, 0.5)  # Adjust the interpolation factor
	position.y = lerped_y
	
func _physics_process(delta):
	position.y = clamp(position.y, MIN_Y, MAX_Y)

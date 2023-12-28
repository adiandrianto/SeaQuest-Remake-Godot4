extends Area2D

const SHARK_SPEED = 40
const MOVE_FREQ = 0.15
const MOVE_AMP = 0.5
const body_pieces = preload("res://scenes/body_pieces.tscn")
const shark_death = preload("res://enemies/shark/shark_death.ogg")
var vel = Vector2(1,0)
var state = "default"

@onready var sprite = $sprite
@onready var timer = $Timer

func _ready():
	GameEvent.connect("pause_enemies",Callable(self, "on_pause"))
	
func _process(_delta):
	if global_position.x < Global.MIN_BBOX_X or global_position.x > Global.MAX_BBOX_X:
		queue_free()
		
func _physics_process(delta):
	if state == "default" :
		vel.y = sin(global_position.x * MOVE_FREQ) * MOVE_AMP
		global_position += vel * SHARK_SPEED * delta

func _on_area_entered(area):
	if area.is_in_group("bullet"):
		Global.increased_points(50)
		GameEvent.emit_signal("points_updated")
		AudioManager.play_audio(shark_death)
		death_sequence()
		area.queue_free()
		queue_free()
		timer.start()
		
	if area.is_in_group("player"):
		GameEvent.emit_signal("game_over")
		
func death_sequence():
	for i in range(2):
		var body_pieces_instance = body_pieces.instantiate()
		body_pieces_instance.frame = i
		get_tree().current_scene.add_child(body_pieces_instance)
		body_pieces_instance.global_position = global_position
	
	
func flip_direction():
	vel = -vel
	sprite.flip_h = !sprite.flip_h
	
func _on_timer_timeout():
	sprite.play("default")

func on_pause(pause):
	if pause :
		state = "paused"
		sprite.stop()
	else :
		sprite.play()
		state = "default"
		

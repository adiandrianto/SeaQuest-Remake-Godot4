extends Area2D

var vel = Vector2(0,0)
var can_shoot = true
var state = "default"
const speed = Vector2(120,90)
const player_bullet_scene = preload("res://player_bullet.tscn")
const BULLET_OFFSET = 7
const OXYGEN_DEPLETED_SPEED = 20
const OXYGEN_REFILL_SPEED = 60
const MIN_X = 24
const MAX_X = 242
const MIN_Y = 38
const MAX_Y = 222
@onready var reload_timer = $reloadTimer
@onready var sprite = $sprite
@onready var person_unload_timer = $personUnloadTimer

func _ready():
	GameEvent.connect("full_crew", Callable(self, "on_full_crew"))
	GameEvent.connect("partial_crew", Callable(self, "oxygenized"))
	
func _process(_delta):	
	if state == "default":
		process_movement()
		shoot()
		deplete_oxygen()	
	elif state == "oxygenized":
		refill_oxygen()
	elif state == "on_full_crew":
		refill_oxygen()
	
	print(Global.total_person_saved)
func process_movement():
	vel.x = Input.get_axis("move_left", "move_right")
	vel.y = Input.get_axis("move_up", "move_down")
	vel = vel.normalized()
	
	if vel.x < 0 :
		sprite.flip_h = true
	elif vel.x > 0:
		sprite.flip_h = false
	
	global_position.x = clamp(global_position.x, MIN_X, MAX_X)
	global_position.y = clamp(global_position.y, MIN_Y, MAX_Y)
	global_position += vel * get_physics_process_delta_time() * speed
	
func shoot():
	if Input.is_action_pressed("shoot") && can_shoot:
		var bullet_instance = player_bullet_scene.instantiate()
		bullet_instance.global_position = global_position
		get_tree().current_scene.add_child(bullet_instance)
		
		if sprite.flip_h == true:
			bullet_instance.flip_direction()
			bullet_instance.vel.y = - bullet_instance.vel.y
			bullet_instance.global_position = global_position - Vector2(BULLET_OFFSET,0)
		else :
			bullet_instance.global_position = global_position + Vector2(BULLET_OFFSET,0)
		
		can_shoot = false
		reload_timer.start()

func deplete_oxygen():
	Global.oxygen_level = move_toward(Global.oxygen_level, 0.0, OXYGEN_DEPLETED_SPEED * get_process_delta_time()) 

func _on_reload_timer_timeout():
	can_shoot = true

func refill_oxygen():
	Global.oxygen_level = move_toward(Global.oxygen_level, 100.0, OXYGEN_REFILL_SPEED * get_process_delta_time())
	if Global.oxygen_level > 99:
		state = "default"

func on_full_crew():
	print("crew full")
	state = "full_crew"
	Global.total_person_saved -= 1
	GameEvent.emit_signal("person_updated")
	print(Global.total_person_saved)
	
	if Global.total_person_saved <= 0 :
		state = "oxygenized"
		
	
# partial_crew
func oxygenized():
	state = "oxygenized"
	refill_oxygen()	
		

func _on_person_unload_timer_timeout():
	Global.total_person_saved -= 1
	GameEvent.emit_signal("person_updated")
	print(Global.total_person_saved)
	
	if Global.total_person_saved <= 0 :
		state = "oxygenized"
		person_unload_timer.stop()
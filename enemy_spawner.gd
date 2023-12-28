extends Node2D

@onready var enemy_timer = %spawnTimer
@onready var person_timer = %personTimer
@onready var left = %left
@onready var right = %right
const shark_instance = preload("res://shark.tscn")
const person_instance = preload("res://person.tscn")

func _ready():
	enemy_timer.wait_time = randf_range(1,3)
	enemy_timer.start()
	GameEvent.connect("game_over", Callable(self, "on_game_over"))

func _on_timer_timeout():
	spawn_enemy()
	
func spawn_enemy():
	var shark = shark_instance.instantiate()
	var spawner_selected = randi_range(1,4)
	var spawner_side = bool(randi_range(0,1))
	var selected_side
	
	if spawner_side:
		selected_side = right
	else:
		selected_side = left
	
	var spawn_point = selected_side.get_node(str(spawner_selected))
	var spawn_position = spawn_point.global_position
	shark.global_position = spawn_position
	get_tree().current_scene.add_child(shark)
	
	if spawner_side:
		shark.flip_direction()

func _on_person_timer_timeout():
	spawn_person()
	

func spawn_person():
	var person = person_instance.instantiate()
	var spawner_selected = randi_range(1,4)
	var spawner_side = bool(randi_range(0,1))
	var selected_side
	
	if spawner_side:
		selected_side = right
	else:
		selected_side = left
	
	var spawn_point = selected_side.get_node(str(spawner_selected))
	var spawn_position = spawn_point.global_position
	person.global_position = spawn_position
	get_tree().current_scene.add_child(person)
	
	if spawner_side:
		person.flip_direction()
		
func on_game_over():
	enemy_timer.stop()
	person_timer.stop()
	

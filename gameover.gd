extends Control

@onready var gameover_label = $gameoverLabel
@onready var score_label = $scoreLabel
@onready var highscore_label = $highscoreLabel
@onready var timer = $Timer
@onready var player = %player

const gameover_sound = preload("res://player/gameover.wav")

func _ready():
	GameEvent.connect("game_over", Callable(self, "on_game_over"))
	visible = false
	
func _process(delta):
	if Input.is_action_just_pressed("shoot") && visible==true :
		get_tree().reload_current_scene()
	
func on_game_over():
	score_label.text = "score " + str(Global.total_points)
	player.set_physics_process(false)
	player.set_process(false)
	GameEvent.emit_signal("pause_enemies", true)
	if Global.total_points > Global.highscore :
		Global.highscore = Global.total_points
		
	highscore_label.text = "highscore " + str(Global.total_points)	
	get_tree().create_timer(1.0).timeout.connect(on_timer_timeout)
	
func on_timer_timeout():
	AudioManager.play_audio(gameover_sound)
	visible = true



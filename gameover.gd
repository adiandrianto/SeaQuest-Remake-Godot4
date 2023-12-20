extends Control

@onready var gameover_label = $gameoverLabel
@onready var score_label = $scoreLabel
@onready var highscore_label = $highscoreLabel
@onready var timer = $Timer

func _ready():
	GameEvent.connect("game_over", Callable(self, "on_game_over"))
	
	visible = false
	
func on_game_over():
	score_label.text = "score " + str(Global.total_points)
	
	if Global.total_points > Global.highscore :
		Global.highscore = Global.total_points
		
	highscore_label.text = "highscore " + str(Global.total_points)	
	get_tree().create_timer(0.7).timeout.connect(on_timer_timeout)
	
func on_timer_timeout():
	visible = true

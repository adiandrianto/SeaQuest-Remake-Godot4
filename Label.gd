extends Label

func _ready():
	GameEvent.connect("points_updated", Callable(self, "on_points_updated"))
	
func on_points_updated():
	text = str(Global.total_points)

extends AudioStreamPlayer

func _ready():
	connect("finished", Callable(self, "on_finished"))
	
func on_finished():
	queue_free()

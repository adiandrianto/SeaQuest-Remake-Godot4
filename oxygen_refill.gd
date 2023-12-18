extends Area2D

var area

func _process(delta):
	if not get_overlapping_areas().is_empty() :
		if Global.total_person_saved >= 7 :
			GameEvent.emit_signal("full_crew")
		elif Global.total_person_saved >= 0 :
			GameEvent.emit_signal("partial_crew")
			print("signal partial")

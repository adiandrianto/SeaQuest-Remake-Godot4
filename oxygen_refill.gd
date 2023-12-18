extends Area2D

var area

#func _process(delta):
	#if not get_overlapping_areas().is_empty() && Global.total_person_saved >= 0:
		#if Global.total_person_saved >= 7 :
		#	GameEvent.emit_signal("full_crew")
		#elif Global.total_person_saved >= 0 :
			#GameEvent.emit_signal("partial_crew")
			#print("signal partial")


func _on_area_entered(area):
	if Global.total_person_saved >= 7 :
		GameEvent.emit_signal("full_crew")
		print("signal full")
	elif Global.total_person_saved >= 0:
		GameEvent.emit_signal("partial_crew")
		print("signal partial")

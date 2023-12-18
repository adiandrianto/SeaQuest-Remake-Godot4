extends Node

var total_person_saved = 5
var oxygen_level = 100
var total_points = 0
	
func increased_person_saved():
	total_person_saved += 1
	GameEvent.emit_signal("person_updated")
	
func increased_points(points):
	total_points += points

extends Node

var total_person_saved = 0
var oxygen_level = 100

func increased_person_saved():
	total_person_saved += 1
	GameEvent.emit_signal("person_updated")

extends Node

const soundscript = preload("res://sound.gd")
func play_audio(sound):
	var audiostream = AudioStreamPlayer.new()
	audiostream.set_script(soundscript)
	audiostream.stream = sound
	add_child(audiostream)
	audiostream.play()

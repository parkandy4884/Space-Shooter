extends Control

func _ready():
	Global.scores = [
		{"name" : "Jason","score":300},
		{"name" : "Jason","score":100},
		{"name" : "Jason","score":50}
	]
	$Label.text = "Thanks for playing!\n Your final score was " + str(Global.score) + "."
	$Scores.text = "High Scores:\n"
	for score in Global.scores:
		$Scores.text = $Scores.text + str(score["score"]) + "\n"

func _on_play_pressed():
	Global.reset()
	get_tree().change_scene_to_file("res://game.tscn")

func _on_quit_pressed():
	get_tree().quit()

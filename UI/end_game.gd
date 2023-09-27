extends Control

func _ready():
	Global.add_score()
	$Label.text = "Thanks for playing!\n Your final score was " + str(Global.score) + "."
	$Scores.text = "High Scores:\n"
	var count = 0
	for score in Global.scores:
		$Scores.text = $Scores.text + str(score["score"]) + "\n"
		count += 1

func _on_play_pressed():
	Global.reset()
	get_tree().change_scene_to_file("res://game.tscn")

func _on_quit_pressed():
	get_tree().quit()

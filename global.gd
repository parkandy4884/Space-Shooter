extends Node

const SCORES = "user://scores.sav"
const SECRET = "HIGH"

var VP = Vector2.ZERO
var score = 0
var lives = 0
var level = -1

var levels = [
	{
		"title":"Level 1",
		"subtitle":"Destory the asteroids",
		"asteroids":[Vector2(100,100), Vector2(900,500)],
		"enemies":[],
		"timer":100,
		"asteroids_spawned":false,
		"enemies_spawned":false
	},
	{
		"title":"Level 2",
		"subtitle":"Destory the asteroids and watch out for the enemy",
		"asteroids":[Vector2(100,100),Vector2(900,500),Vector2(800,200)],
		"enemies":[Vector2(150,500)],
		"timer":80,
		"asteroids_spawned":false,
		"enemies_spawned":false
	}
	
	
]

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	randomize()
	VP = get_viewport().size
	var _signal = get_tree().get_root().size_changed.connect(_resize)
	reset()

func _physics_process(_delta):
	var A = get_node_or_null("/root/Game/Asteroid_Container")
	var E = get_node_or_null("/root/Game/Enemy_Container")
	if A != null and E !=null:
		var L = levels[level]
		if L["asteroids_spawned"] and A.get_child_count() == 0 and L["enemies_spawned"] and E.get_child_count() == 0:
			next_level()

func reset():
	get_tree().paused = false
	score = 0
	lives = 5
	level = -1
	for l in levels:
		l["asteroids_spawned"] = false
		l["enemies_spawned"] = false

func _process(_delta):
	if Input.is_action_just_pressed("Quit"):
		var menu = get_node_or_null("/root/Game/UI/Menu")
		if menu == null:
			get_tree().quit()
		else:
			if menu.visible:
				get_tree().paused = false
				menu.hide()
			else:
				get_tree().paused = true
				menu.show()
	var Asteroid_Container = get_node_or_null("/root/Game/Astroid_Container")
	var Enemy_Container = get_node_or_null("/root/Game/Enemy_Container")
	if Asteroid_Container != null and Enemy_Container != null:
		if Asteroid_Container.get_child_count() == 0 and Enemy_Container.get_child_count() == 0:
			get_tree().change_scene_to_file("res://UI/end_game.tscn")


func update_lives(l):
	lives += l
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_lives()
	if lives < 0:
		get_tree().change_scene_to_file("res://UI/end_game.tscn")
	
func update_score(s):
	score += s
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_score()

func next_level():
	level += 1
	if level >= levels.size():
		get_tree().change_scene_to_file("res://UI/end_game.tscn") 
	else:
		var Level_Label = get_node_or_null("/root/Game/UI/Level")
		if Level_Label != null:
			Level_Label.show_labels()

func _resize():
	VP = get_viewport().size
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_lives()

func load_scores():
if not FileAccess.file_exists(SCORES):
return
var save_scores = FileAccess.open(SCORES,FileAccess.READ)

save_scores.open_encrypted_with_pass(SCORES, FileAccess.READ, SECRET)
var contents = save_scores.get_as_text()
var json_object = JSON.new()
var json_contents = json_object.parse(contents)
if json_contents.error == OK:
scores = json_contents
save_scores.close()

func save_scores():
var save_scores = FileAccess.open(SCORES,FileAccess.WRITE)
save_scores.open_encrypted_with_pass(SCORES, FileAccess.WRITE, SECRET)
var json = JSON.new()
var json_string = json.stringify(scores)
save_scores.store_string(json_string)
save_scores.close()

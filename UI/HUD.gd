extends Control

var Indicator = load("res://UI/indicator.tscn")
var lives_pos = Vector2(20, Global.VP.y - 20)
var lives_index = 30

func _ready():
	update_score()
	update_lives()

func _physics_process(_delta):
	var Player = get_node_or_null("/root/Game/Player_Container/Player")
	if Player == null:
		$Health2.hide()
	else:
		$Health2.show()
		$Health2.global_position = Player.global_position - Vector2(50,-100)
		$Health2.value = clamp(Player.health*100 / 10,0,100)

func update_score():
	$Score.text = "Score: " + str(Global.score)

	
func update_lives():
	lives_pos = Vector2(20, Global.VP.y - 20)
	for child in $Indicator_Container.get_children():
		child.queue_free()
	for i in range(Global.lives):
		var indicator = Indicator.instantiate()
		indicator.position = lives_pos + Vector2(lives_index*i, 0)
		$Indicator_Container.add_child(indicator)



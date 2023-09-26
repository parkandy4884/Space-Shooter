extends Node2D

var Enemy = load("res://Enemy/enemy.tscn")

func _physics_process(_delta):
	if get_child_count() == 0 and Global.level < Global.levels.size():
		var level = Global.levels[Global.level]
		if not level["enemies_spawned"]:
			for pos in level["enemies"]:
				var enemy = Enemy.instantiate()
				enemy.position = pos
				add_child(enemy)
			level["enemies_spawned"] = true

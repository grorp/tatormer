extends Area2D

func _on_body_entered(body):
	if body == $"../Player":
		body.frozen = true
		$LevelUpSound.play()
		yield($LevelUpSound, "finished")
		yield(get_tree().create_timer(1), "timeout")
		LevelSwitcher.level_up()

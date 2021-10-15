extends Area2D

func _on_body_entered(body):
	if $AnimationPlayer.current_animation == "collect":
		return
	if body == $"../../Player" and !body.frozen:
		LevelSwitcher.player_collect_coin()
		$CollectSound.play()
		$AnimationPlayer.play("collect")


func _on_animation_finished(anim_name):
	if anim_name == "collect":
		queue_free()

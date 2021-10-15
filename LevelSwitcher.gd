extends Node

var current_level = 1
const MAX_LEVEL = 4

var player_coins = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func restart_level():
	get_tree().reload_current_scene()

func level_up():
	if current_level >= MAX_LEVEL:
		if current_level == MAX_LEVEL and OS.get_date().month == 12 and OS.get_date().day > 20:
			current_level += 1
			get_tree().change_scene("res://scenes/levels/christmas/ChristmasLevel.tscn")
			return
		get_tree().quit()
		return
	current_level += 1
	get_tree().change_scene("res://scenes/levels/Level" + str(current_level) + ".tscn")

func player_collect_coin():
	player_coins += 1

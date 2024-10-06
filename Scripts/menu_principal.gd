extends Control

var game_is_on := false

func _on_jogar_pressed() -> void:
	if !game_is_on:
		WhiteTransition.first_tran()
		game_is_on = true
		Global.in_game = false


func _on_controles_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu_controles.tscn")


func _on_sair_pressed() -> void:
	get_tree().quit()


func _process(delta: float) -> void:
	Global.in_game = true

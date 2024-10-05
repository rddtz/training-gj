extends Control


func _on_voltar_pressed() -> void:
	get_tree().paused = false
	


func _on_sair_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu_principal.tscn")
	

func _ready() -> void:
	pass


func PauseMenu():
	pass
	
func _process(delta: float) -> void:
	PauseMenu()

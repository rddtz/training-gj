extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_voltar_pressed() -> void:
	pass
	

func _on_sair_pressed() -> void:
	
	if Global.paused:
		Global.in_game = false
		get_tree().change_scene_to_file("res://Scenes/menu_principal.tscn")
		turnOff()
	

func _ready() -> void:
	Global.in_game = true 
	pass


func PauseMenu():
	pass
	
func _process(delta: float) -> void:
	menu_logic()


func turnOn():
	get_tree().paused = true
	animation_player.stop()
	animation_player.play("turnOn")
	Global.paused = true
	Global.in_game = false
	
func turnOff():
	get_tree().paused = false
	animation_player.stop()
	animation_player.play_backwards("turnOn")
	Global.paused = false
	Global.in_game = true
	


func menu_logic():
	if Input.is_action_just_pressed("pause") and !Global.paused and Global.in_game == true:
		MenuPause.turnOn()
	elif Input.is_action_just_pressed("pause") and Global.paused and Global.in_game == false:
		MenuPause.turnOff()

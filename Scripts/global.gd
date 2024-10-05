extends Node

var shake := false
var shake_force := 5.0

var do_zoom := false
var zoom_speed := .1
var zoom_size := 2

var paused = false
@onready var pause_menu: Control = $CanvasLayer/Pause


#var transition_resource := preload("res://Scenes/hex_transition.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	paused= false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#Funcao que vai criar as particulas
func create_particles(particles : Resource, min_amount : int, max_amount : int,
x : float, y: float, min_x : float, max_x : float, min_y : float, max_y : float):
	
	var amount := randi_range(min_amount, max_amount)
	
	for i in amount:
		var x_temp := randf_range(min_x, max_x)
		var y_temp := randf_range(min_y, max_y)
		
		var particle = particles.instantiate()
		particle.position = Vector2(x + x_temp, y + y_temp)
		get_tree().current_scene.add_child(particle, true)


func screen_shake(force : float):
	shake = true
	shake_force = force
	
func zoom(size : float, speed : float):
	do_zoom = true
	zoom_size = size
	zoom_speed = speed

#func transition(next_scene : String):
	#var tran := transition_resource.instantiate()
	#tran.next_scene = next_scene
	#get_tree().current_scene.add_child(tran, true)

func transition_hex(next_scene : String, reset : bool):
	HexTransition.fade_in(next_scene, reset)
	
func transition_diamond(next_scene : String, reset : bool):
	DiamondTransition.fade_in(next_scene, reset)
	
func transition_white(next_scene : String, reset : bool):
	WhiteTransition.fade_in(next_scene, reset)

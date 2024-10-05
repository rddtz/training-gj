extends Node2D

var click = false
var click2 = false
var glass = preload("res://Scenes/glass.tscn")
@export var scene_path : String
@export var player : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_U) && !click:
		player.stress_index += 20.0
		click = true
	
	if !Input.is_key_pressed(KEY_U):
		click = false

	if Input.is_key_pressed(KEY_J) && !click2:
		Global.transition_hex(scene_path, 0)
		click2 = true
	
	if !Input.is_key_pressed(KEY_J):
		click2 = false

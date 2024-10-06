extends Node2D

@export var next_scene : String
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var reset_scene := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func fade_in(next : String, reset : bool):
	next_scene = next
	reset_scene = reset
	animation_player.stop()
	animation_player.play("transition")

func first_tran():
	next_scene = "res://Scenes/opening.tscn"
	reset_scene = 0
	animation_player.stop()
	animation_player.play("first_transition")

func zoom_in():
	Global.zoom(3, .1)

func zoom_out():
	Global.zoom(2, .1)

func change_scene():
	if !reset_scene:
		get_tree().change_scene_to_file(next_scene)
	else:
		get_tree().reload_current_scene()

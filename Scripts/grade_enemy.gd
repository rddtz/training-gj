extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var enemy : Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var arrow_sprite: AnimatedSprite2D = $AnimatedSprite2D2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_grade():
	animated_sprite_2d.play(str(enemy.vida));

func up():
	change_grade()
	arrow_sprite.play("up")
	animation_player.play("dissolve")
	
func down():
	change_grade()
	arrow_sprite.play("down")
	animation_player.play("dissolve")

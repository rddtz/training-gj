extends Node2D

@export var player_sprite : AnimatedSprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $CanvasLayer/Scale/RetratoFundo/RetratoMask/Node2D/AnimatedSprite2D
@export var player : Node2D
@onready var vida_barra: Sprite2D = $CanvasLayer/Scale/VidaFundo/VidaMask/VidaBarra

var scale_wished := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.sprite_frames = player_sprite.sprite_frames
	animated_sprite_2d.animation = player_sprite.animation
	animated_sprite_2d.frame = player_sprite.frame
	#animated_sprite_2d.speed_scale = player_sprite.speed_scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	animated_sprite_2d.sprite_frames = player_sprite.sprite_frames
	animated_sprite_2d.animation = player_sprite.animation
	animated_sprite_2d.frame = player_sprite.frame
	#animated_sprite_2d.speed_scale = player_sprite.speed_scale
	life()

func life():
	scale_wished = (player.stress_index * 1.0) / player.stress_max
	#scale_wished = (1 / player.life_max) * -player.life_index + 1;
	vida_barra.scale.x = lerpf(vida_barra.scale.x, scale_wished, .1)

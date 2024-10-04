extends Area2D

var speed := 300
var angle := 0.0
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var player: CharacterBody2D = %Player

func move(delta: float):
	sprite_2d.rotate(0.2)	
	position.x += cos(angle) * speed * delta
	position.y += sin(angle) * speed * delta

func destroy():
	queue_free()

func _process(delta: float) -> void:
	move(delta)
	#f absi(position.x - player.position.x) > 100:
	#	destroy()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Inimigo_medroso" or body.name == "Inimigo_corajoso":
		body.vida -= 1
		body.grade_node.down()
	destroy()

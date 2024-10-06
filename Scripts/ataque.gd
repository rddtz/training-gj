extends Area2D

var speed := 300
var angle := 0.0
@onready var sprite_2d: Sprite2D = $Sprite2D
var particles := preload("res://Scenes/particle_paper.tscn")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func move(delta: float):
	sprite_2d.rotate(0.2)	
	position.x += cos(angle) * speed * delta
	position.y += sin(angle) * speed * delta

func destroy():
	Global.create_particles(particles, 5, 5, position.x, position.y, 0, 0, 0, 0)
	animation_player.play("destroy")

func _process(delta: float) -> void:
	move(delta)
	#f absi(position.x - player.position.x) > 100:
	#	destroy()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Inimigo_medroso" or body.name == "Inimigo_corajoso":
		if body.vida > 0:
			body.vida -= 1     
			body.grade_node.down()
			body.animation_player.stop()
			body.animation_player.play("hit")
			destroy()
	elif body.name != "Player":
		destroy()

extends CharacterBody2D

const MOVEMENT_SPEED = Vector2(200.0, -400.0)
const ACCELERATION = 30 
const FRICTION = 30
const MAX_BUFFER = 5

var stress_max := 100
var stress_index := 0.0
var pulo := MAX_BUFFER
var inv := 0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_timer: Timer = $DeathTimer
var exploded := false
var particles_death := preload("res://Scenes/death_particle.tscn")
@onready var reset_timer: Timer = $ResetTimer
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
var death_sound_played := false
var enemy_in_sight := false

@onready var animation_player: AnimationPlayer = $AnimationPlayer



var objeto : Node2D

func _physics_process(delta: float) -> void:
	# adiciona a gravidade
	
	if stress_index < stress_max:
		
		if stress_index > 0:
			stress_index -= 2*delta
		
		if inv > 0:
			inv -= delta
		
		if not is_on_floor(): 
			velocity += get_gravity() * delta
			pulo -= 1 * delta
		else:
			pulo = MAX_BUFFER
		# pula
		if Input.is_action_just_pressed("jump") and (is_on_floor() or pulo > 0):
			velocity.y = MOVEMENT_SPEED.y
		# direction = direção no eixo x da movimentação (-1,1)
		var direction := Input.get_axis("moveLeft", "moveRight")
		# se input != 0, aplica aceleração à velocidade 
		if direction: velocity.x = velocity.move_toward(MOVEMENT_SPEED * direction, ACCELERATION).x
		# se input == 0, aplica fricção à velocidade 
		else: velocity.x = velocity.move_toward(Vector2.ZERO, FRICTION).x
		playSprite(velocity, direction)
		
		move_and_slide()
	else:
		death()

func get_mouse_angle() -> float:
	var theta := atan2(get_local_mouse_position().y, get_local_mouse_position().x)
	return theta

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		novo_ataque()

func novo_ataque():
	var ataque := preload("res://Scenes/ataque.tscn")
	var ataque_node := ataque.instantiate()
	get_tree().current_scene.add_child(ataque_node, true)
	ataque_node.position = position
	ataque_node.angle = get_mouse_angle()
	ataque_node.rotation = ataque_node.angle + PI / 2

func playSprite(velocity: Vector2, direction: int) -> void:
	# flipa sprite caso estiver andando pra esquerda
	if direction == -1: $AnimatedSprite2D.flip_h = true
	if direction == 1: $AnimatedSprite2D.flip_h = false
	# sprites de andar e ficar parado
	if direction != 0: $AnimatedSprite2D.play("walk")
	else: $AnimatedSprite2D.play("idle")
	# sprite de cair
	if velocity.y > 0: $AnimatedSprite2D.play("fall")
	# sprite de pular
	if velocity.y < 0: $AnimatedSprite2D.play("jump")
	

func death():
	if stress_index >= stress_max && !exploded:
		if !death_sound_played:
			death_sound.play()
			death_sound_played = true
		Global.zoom(3, .1)
		Global.screen_shake(10)
		animated_sprite_2d.modulate = Color.RED
		if death_timer.time_left <= 0:
			death_timer.start()


func _on_death_timer_timeout() -> void:
	exploded = true
	animated_sprite_2d.modulate = Color(255, 255, 255, 0)
	reset_timer.start()
	Global.create_particles(particles_death, 20, 30, position.x, position.y, 0, 0, 0, 0)


func _on_reset_timer_timeout() -> void:
	Global.transition_diamond("", 1)

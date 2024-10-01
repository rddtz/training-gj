extends CharacterBody2D

const MOVEMENT_SPEED = Vector2(200.0, -400.0)
const ACCELERATION = 15
const FRICTION = 30

func _physics_process(delta: float) -> void:
	# adiciona a gravidade
	if not is_on_floor(): velocity += get_gravity() * delta
	# pula
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = MOVEMENT_SPEED.y
	# direction = direção no eixo x da movimentação (-1,1)
	var direction := Input.get_axis("moveLeft", "moveRight")
	# se input != 0, aplica aceleração à velocidade 
	if direction: velocity.x = velocity.move_toward(MOVEMENT_SPEED * direction, ACCELERATION).x
	# se input == 0, aplica fricção à velocidade 
	else: velocity.x = velocity.move_toward(Vector2.ZERO, FRICTION).x
	playSprite(velocity, direction)
	move_and_slide()

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

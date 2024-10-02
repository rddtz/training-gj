extends CharacterBody2D
# Called when the node enters the scene tree for the first time.
const SPEED = 60 #60
var direction := 1

@onready var player: CharacterBody2D = %Player
#@onready var parede_esq: RayCast2D = $ParedeEsq
#@onready var parede_dir: RayCast2D = $ParedeDir
#@onready var chao: RayCast2D = $chao

const MOVEMENT_SPEED = Vector2(200.0, -400.0)
const ACCELERATION = 15
const FRICTION = 30

@export var grade_node : Node2D
var vida := 1
var maxvida := 3

func _ready() -> void:
	grade_node.change_grade()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if not is_on_floor(): velocity += get_gravity() * delta
	
	if player.position.x < position.x: direction = -1
	else: if player.position.x > position.x: direction = 1
	else: direction = 0
	
	
	if direction: velocity.x = velocity.move_toward(MOVEMENT_SPEED * direction, ACCELERATION).x
	
	if direction == -1: $AnimatedSprite2D.flip_h = true
	if direction == 1: $AnimatedSprite2D.flip_h = false
	# sprites de andar e ficar parado
	if direction != 0: $AnimatedSprite2D.play("walk")
	else: $AnimatedSprite2D.play("idle")
	
	move_and_slide()
	#if direction != 0: 	position.x += direction * SPEED * delta


func _on_dano_body_entered(body: Node2D) -> void:
	# Ativar o dano
	print("dano")
	if body.name == 'Player': 
		if vida < maxvida:
			vida += 1
		grade_node.up()

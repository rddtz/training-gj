extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func create_particles(particles : Resource, min_amount : int, max_amount : int,
x : float, y: float, min_x : float, max_x : float, min_y : float, max_y : float):
	
	var amount := randi_range(min_amount, max_amount)
	
	for i in amount:
		var x_temp := randf_range(min_x, max_x)
		var y_temp := randf_range(min_y, max_y)
		
		var particle = particles.instantiate()
		particle.position = Vector2(x + x_temp, y + y_temp)
		get_tree().current_scene.add_child(particle, true)

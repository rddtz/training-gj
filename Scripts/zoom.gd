extends Node

@export var cam : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.do_zoom:
		cam.zoom.x = lerpf(cam.zoom.x, Global.zoom_size, Global.zoom_speed)
		cam.zoom.y = lerpf(cam.zoom.y, Global.zoom_size, Global.zoom_speed)
		
		if cam.zoom.x == Global.zoom_size && cam.zoom.y == Global.zoom_size:
			Global.do_zoom = false

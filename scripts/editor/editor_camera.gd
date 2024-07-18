extends CharacterBody3D

@onready var pivot = $Pivot
@onready var camera = $Pivot/Camera3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var is_mouse_locked:bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_mouse_locked:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _input(event):
	if event.is_action_released("editor_cam_lock"):
		is_mouse_locked = !is_mouse_locked


func _unhandled_input(event):
	if (
		event is InputEventMouseMotion &&
		is_mouse_locked
	):
		pivot.rotate_y(-event.relative.x * 0.01)
		camera.rotate_x(-event.relative.y * 0.01)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))


func _physics_process(delta):
	var input_dir = Input.get_vector("editor_cam_left", "editor_cam_right", "editor_cam_up", "editor_cam_down")
	var direction = (pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

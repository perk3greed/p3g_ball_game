extends CharacterBody3D

var times_jumped :int = 0 
var jump_ready :bool 


func _ready():
	Events.connect("ball_is_out_of_bounds", restart_position)



func _physics_process(delta):
	
	if times_jumped < 2:
		jump_ready = true
	else:
		jump_ready = false
	
	
	if Input.is_action_pressed("W"):
		velocity = basis.z*4
	
	if Input.is_action_pressed("A"):
		rotate_y(0.05)
	
	
	if Input.is_action_pressed("S"):
		velocity = -basis.z/4
		
	
	if Input.is_action_pressed("D"):
		rotate_y(-0.05)
		
	
	if Input.is_action_just_pressed("ui_accept") and jump_ready:
		velocity.y = 5
		times_jumped += 1 
	
	
	if is_on_floor():
		times_jumped = 0
	else :
		velocity.y -= delta*20
	
	move_and_slide()







func restart_position():
	$SpringArm3D/Camera3D.clear_current()
#	await get_tree().create_timer(0.1ц).timeout
	self.queue_free()

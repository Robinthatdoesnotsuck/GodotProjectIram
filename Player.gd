extends KinematicBody

#next change scene and update score
var moveSpeed:float = 5
var jumpForce:float = 5
var gravity:float=12


#camlook
var minLookAngle:float = -90
var maxlookAngle:float = 90
var sensitivity:float = 10
var velocity:Vector3 = Vector3()
var mouseDelta: Vector2 = Vector2()
#var scoreUI:RichTextLabel
var score = 0
var message_timer:Timer

onready var camera :Camera = get_node("Camera") #only when node is initialized
onready var user_message:Label = get_node("./Message")
onready var score_message:Label = get_node("./Score")

func _ready():
	message_timer = Timer.new()
	add_child(message_timer)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	user_message.set_text("")
	score_message.set_text("Score :" + str(score))
	
	



func _physics_process(delta):#called 60 times per sec
	velocity.x = 0
	velocity.z = 0
	var input:Vector2 = Vector2()
	if Input.is_action_pressed("move_forward"):
		input.y+=1
	if Input.is_action_pressed("move_back"):
		input.y-=1	
	if Input.is_action_pressed("move_left"):
		input.x+=1		
	if Input.is_action_pressed("move_right"):
		input.x-=1		
	input.normalized();
	
	var forward = global_transform.basis.z;
	var right = global_transform.basis.x;
	
	var relativeDirection = (forward * input.y + right*input.x);
	velocity.x = relativeDirection.x * moveSpeed
	velocity.z = relativeDirection.z * moveSpeed
	
	velocity.y -=gravity*delta;#every second we remove delta
	velocity=  move_and_slide(velocity, Vector3.UP);
	
	
	pass
	if (Input.is_action_pressed("jump")) and is_on_floor():
		velocity.y = jumpForce
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if(collision.collider.is_in_group("collect")):
			print("Collision with: " + collision.collider.name)
			score += 1
			print("score " + str(score))
			score_message.set_text("Score :" + str(score))
			user_message.set_text("You have collected an object")
			message_timer.connect("timeout", self, "clear_text")
			message_timer.set_wait_time(5)
			message_timer.start()
			collision.collider.queue_free()	
		elif(collision.collider.name == "End" && score == 4):
			print("Congratulations!!")
			user_message.set_text("CONGRATULATIONS")
		

	
func _process(delta):#not physics related
	camera.rotation_degrees.x -= mouseDelta.y*sensitivity*delta
	
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle,maxlookAngle)
	#around y axis
	rotation_degrees.y -= mouseDelta.x*sensitivity*delta
	
	#reset mousedelta
	mouseDelta = Vector2()
func _input(event):
	#print("Test")
	if event is InputEventMouseMotion	:
		mouseDelta = event.relative
func clear_text():
	user_message.set_text("")

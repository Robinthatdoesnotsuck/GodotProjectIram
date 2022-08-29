extends CSGBox
export(PackedScene) var ball




func _ready():
	pass # Replace with function body.

func _input(event):
	if(Input.is_key_pressed(KEY_O)):
		var new_ball = ball.instance()
		add_child(new_ball)
		var timer = Timer.new()
		new_ball.add_child(timer)
		timer.connect("timeout", new_ball, "queue_free")
		timer.set_wait_time(2)
		timer.start()

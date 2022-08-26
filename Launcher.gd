extends CSGBox
export(PackedScene) var ball

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if(Input.is_key_pressed(KEY_O)):
		var new_ball = ball.instance()
		add_child(new_ball)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

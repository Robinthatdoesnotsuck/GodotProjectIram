extends TextureRect

func _ready():
	var viewport_size = get_viewport().size
	self.rect_position = viewport_size/2 - self.rect_size/2

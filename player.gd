extends Area2D
signal hit

@export var speed = 400
var screen_size
var spectrum

func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(240,360)
	
	spectrum = AudioServer.get_bus_effect_instance(1,1)

func _process(delta):
	var velocity = Vector2.ZERO
	var prev_hz = 0
	var hz = 1000.0
	
	var magnitude = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
	print("Audio output: ", magnitude)
	
	if magnitude > 0.002:
		velocity.y -= 1
		$AnimatedSprite2D.play()
	else:
		velocity.y += 1
		$AnimatedSprite2D.stop()
		
	if velocity.length() > 0:
		velocity = velocity * speed
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.y != 0:
		$AnimatedSprite2D.animation = "flying"
		$AnimatedSprite2D.flip_v = velocity.y > 0

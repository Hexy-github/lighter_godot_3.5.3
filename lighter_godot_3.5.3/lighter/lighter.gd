extends KinematicBody2D
var power := 1

func _physics_process(delta):
	pass
var dragg := false
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed()  :
			if event.button_index:
				
				dragg = true
		else:
			if event.button_index:
				
				dragg = false
	if dragg:
		if event is InputEventMouseMotion:
			$base/fire.rotation_degrees = clamp(-(event.relative.x) * 1,-80,80) 

			print( (event.relative.y / 10))
			$base/fire.scale.y = (event.relative.y / 10) + power # clamp ((event.relative.y),power - .5,power + .5 )
			global_position += event.relative




func _on_lighter_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			$on.play()
			$base/LighterButton.position.y = 42
			$base/fire/fire_anim.show()
			$base/fire/fire_anim/Area2D.monitoring = true
		else:
			$off.play()
			$base/LighterButton.position.y = 0
			$base/fire/fire_anim.hide()
			$base/fire/fire_anim/Area2D.monitoring = false
	


func _on_TouchScreenButton_pressed():

	var d : float = $base/fire.scale.y
	
	$base/fire.scale.y = 3
	power = 3
	if d >2:
		power = 1
		$base/fire.scale.y = 1
	


func _on_Area2D_body_entered(body):
	if body.is_in_group("candle_fire"):
		body.get_node("candle").show()

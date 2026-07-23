extends Control

var type = ""
var background_sprite : Texture2D
var foreground_sprite : Texture2D

var active = true

func init(_type, name) -> void:
	type = name
	background_sprite = _type["background"]
	foreground_sprite = _type["foreground"]
	$"%Background".texture = background_sprite
	$"%Foreground".texture = foreground_sprite

func _process(delta: float) -> void:
	$"%Background".texture = background_sprite
	$"%Foreground".texture = foreground_sprite
	
	if not active:
		self.free()
		return

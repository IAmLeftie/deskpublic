extends Node2D

@onready var moodle_scene = preload("res://scenes/moodle.tscn")
@onready var behavior = $"%behavior"

var moodles = []

const MOODLE_DEFINITIONS = {
	"sad": {"background": preload("res://assets/moodles/mood1.png"), "foreground": preload("res://assets/moodles/sad.png")},
	"gloomy": {"background": preload("res://assets/moodles/mood2.png"), "foreground": preload("res://assets/moodles/gloomy.png")},
	"depressed": {"background": preload("res://assets/moodles/mood3.png"), "foreground": preload("res://assets/moodles/depression.png")},
	"miserable": {"background": preload("res://assets/moodles/mood4.png"), "foreground": preload("res://assets/moodles/miserable.png")},
	"satisfied": {"background": preload("res://assets/moodles/mood5.png"), "foreground": preload("res://assets/moodles/happy.png")},
	"excited": {"background": preload("res://assets/moodles/mood6.png"), "foreground": preload("res://assets/moodles/happy.png")},
	"happy": {"background": preload("res://assets/moodles/mood7.png"), "foreground": preload("res://assets/moodles/happy.png")},
	"gleeful": {"background": preload("res://assets/moodles/mood8.png"), "foreground": preload("res://assets/moodles/happy.png")},
	
	"full": {"background": preload("res://assets/moodles/mood6.png"), "foreground": preload("res://assets/moodles/happy.png")},
	"satiated": {"background": preload("res://assets/moodles/mood5.png"), "foreground": preload("res://assets/moodles/hunger.png")},
	"peckish": {"background": preload("res://assets/moodles/mood1.png"), "foreground": preload("res://assets/moodles/hunger.png")},
	"hungry": {"background": preload("res://assets/moodles/mood2.png"), "foreground": preload("res://assets/moodles/hunger.png")},
	"veryhungry": {"background": preload("res://assets/moodles/mood3.png"), "foreground": preload("res://assets/moodles/hunger.png")},
	"starving": {"background": preload("res://assets/moodles/mood4.png"), "foreground": preload("res://assets/moodles/hunger.png")},
	
	"waterintoxicated": {"background": preload("res://assets/moodles/mood4.png"), "foreground": preload("res://assets/moodles/overhydrated.png")},
	"overhydrated": {"background": preload("res://assets/moodles/mood2.png"), "foreground": preload("res://assets/moodles/overhydrated.png")},
	"slaked": {"background": preload("res://assets/moodles/mood1.png"), "foreground": preload("res://assets/moodles/overhydrated.png")},
	"thirsty": {"background": preload("res://assets/moodles/mood1.png"), "foreground": preload("res://assets/moodles/thirst.png")},
	"dehydrated": {"background": preload("res://assets/moodles/mood2.png"), "foreground": preload("res://assets/moodles/thirst.png")},
	"parched": {"background": preload("res://assets/moodles/mood3.png"), "foreground": preload("res://assets/moodles/thirst.png")},
	"dessicated": {"background": preload("res://assets/moodles/mood4.png"), "foreground": preload("res://assets/moodles/thirst.png")},
}

func _process(delta: float) -> void:
	pass
	
	
func add_moodle(type: String):
	var new_moodle = moodle_scene.instantiate()
	new_moodle.init(MOODLE_DEFINITIONS.get(type), type)
	$HBoxContainer.add_child(new_moodle)
	moodles.push_back(new_moodle)

func remove_moodle(type: String):
	for i in range(moodles.size()):
		if moodles[i].type == type:
			moodles[i].active = false
			$HBoxContainer.remove_child(moodles[i])
			continue

func has_moodle(type: String):
	for i in range(moodles.size()):
		if moodles[i].type == type:
			return true
	return false


func _on_area_2d_mouse_entered() -> void:
	$HBoxContainer.visible = true

func _on_area_2d_mouse_exited() -> void:
	$HBoxContainer.visible = false

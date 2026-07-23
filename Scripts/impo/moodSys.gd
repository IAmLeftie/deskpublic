extends Node
# yeah
# mood system or whatevah
# oh gosh

@export var tick: float = 0
@export var eyeNode: Sprite2D
@export var mouthNode: Sprite2D

@export var MoodleDisplay : Node


@onready var mood: float = gbData.data.save.mood
@onready var trust: float = gbData.data.save.trust


@onready
var minmood = gbData.settings["minMood"]
@onready
var maxmood = gbData.settings["maxMood"]

func _ready() -> void:
	#initializeloops and signals
	moodLoop()
	hungerThirstLoop()


#make sure things are updated

func _sync_mood() -> void:
	#gbData.data.save.mood = mood
	minmood = gbData.settings["minMood"]
	maxmood = gbData.settings["maxMood"]
	gbData.savetodisk("user://SAVE.json", gbData.data)

# hunger and thirst loop
func hungerThirstLoop() -> void:
	while true:
		await get_tree().create_timer(10).timeout
		
		var h = gbData.data.save.hunger
		if h > 120:
			if not MoodleDisplay.has_moodle("full"):
				MoodleDisplay.add_moodle("full")
			MoodleDisplay.remove_moodle("satiated")
			MoodleDisplay.remove_moodle("peckish")
			MoodleDisplay.remove_moodle("hungry")
			MoodleDisplay.remove_moodle("veryhungry")
			MoodleDisplay.remove_moodle("starving")
		elif h > 100:
			if not MoodleDisplay.has_moodle("satiated"):
				MoodleDisplay.add_moodle("satiated")
			MoodleDisplay.remove_moodle("full")
			MoodleDisplay.remove_moodle("peckish")
			MoodleDisplay.remove_moodle("hungry")
			MoodleDisplay.remove_moodle("veryhungry")
			MoodleDisplay.remove_moodle("starving")
		elif h < 75 and h > 50:
			if not MoodleDisplay.has_moodle("peckish"):
				MoodleDisplay.add_moodle("peckish")
			MoodleDisplay.remove_moodle("satiated")
			MoodleDisplay.remove_moodle("full")
			MoodleDisplay.remove_moodle("hungry")
			MoodleDisplay.remove_moodle("veryhungry")
			MoodleDisplay.remove_moodle("starving")
		elif h < 50 and h > 35:
			if not MoodleDisplay.has_moodle("hungry"):
				MoodleDisplay.add_moodle("hungry")
			MoodleDisplay.remove_moodle("satiated")
			MoodleDisplay.remove_moodle("peckish")
			MoodleDisplay.remove_moodle("full")
			MoodleDisplay.remove_moodle("veryhungry")
			MoodleDisplay.remove_moodle("starving")
		elif h < 35 and h > 15:
			if not MoodleDisplay.has_moodle("veryhungry"):
				MoodleDisplay.add_moodle("veryhungry")
			MoodleDisplay.remove_moodle("satiated")
			MoodleDisplay.remove_moodle("peckish")
			MoodleDisplay.remove_moodle("hungry")
			MoodleDisplay.remove_moodle("full")
			MoodleDisplay.remove_moodle("starving")
		elif h <= 15:
			if not MoodleDisplay.has_moodle("starving"):
				MoodleDisplay.add_moodle("starving")
			MoodleDisplay.remove_moodle("satiated")
			MoodleDisplay.remove_moodle("peckish")
			MoodleDisplay.remove_moodle("hungry")
			MoodleDisplay.remove_moodle("veryhungry")
			MoodleDisplay.remove_moodle("full")
		else:
			MoodleDisplay.remove_moodle("full")
			MoodleDisplay.remove_moodle("satiated")
			MoodleDisplay.remove_moodle("peckish")
			MoodleDisplay.remove_moodle("hungry")
			MoodleDisplay.remove_moodle("veryhungry")
			MoodleDisplay.remove_moodle("starving")
			
		var t = gbData.data.save.thirst
		if t > 175:
			if not MoodleDisplay.has_moodle("waterintoxicated"):
				MoodleDisplay.add_moodle("waterintoxicated")
			MoodleDisplay.remove_moodle("overhydrated")
			MoodleDisplay.remove_moodle("slaked")
			MoodleDisplay.remove_moodle("thirsty")
			MoodleDisplay.remove_moodle("dehydrated")
			MoodleDisplay.remove_moodle("parched")
			MoodleDisplay.remove_moodle("dessicated")
		elif t > 125:
			if not MoodleDisplay.has_moodle("overhydrated"):
				MoodleDisplay.add_moodle("overhydrated")
			MoodleDisplay.remove_moodle("waterintoxicated")
			MoodleDisplay.remove_moodle("slaked")
			MoodleDisplay.remove_moodle("thirsty")
			MoodleDisplay.remove_moodle("dehydrated")
			MoodleDisplay.remove_moodle("parched")
			MoodleDisplay.remove_moodle("dessicated")
		elif t > 100:
			if not MoodleDisplay.has_moodle("slaked"):
				MoodleDisplay.add_moodle("slaked")
			MoodleDisplay.remove_moodle("overhydrated")
			MoodleDisplay.remove_moodle("waterintoxicated")
			MoodleDisplay.remove_moodle("thirsty")
			MoodleDisplay.remove_moodle("dehydrated")
			MoodleDisplay.remove_moodle("parched")
			MoodleDisplay.remove_moodle("dessicated")
		elif t <= 75 and t > 55:
			if not MoodleDisplay.has_moodle("thirsty"):
				MoodleDisplay.add_moodle("thirsty")
			MoodleDisplay.remove_moodle("overhydrated")
			MoodleDisplay.remove_moodle("slaked")
			MoodleDisplay.remove_moodle("waterintoxicated")
			MoodleDisplay.remove_moodle("dehydrated")
			MoodleDisplay.remove_moodle("parched")
			MoodleDisplay.remove_moodle("dessicated")
		elif t <= 55 and t > 35:
			if not MoodleDisplay.has_moodle("dehydrated"):
				MoodleDisplay.add_moodle("dehydrated")
			MoodleDisplay.remove_moodle("overhydrated")
			MoodleDisplay.remove_moodle("slaked")
			MoodleDisplay.remove_moodle("thirsty")
			MoodleDisplay.remove_moodle("waterintoxicated")
			MoodleDisplay.remove_moodle("parched")
			MoodleDisplay.remove_moodle("dessicated")
		elif t <= 35 and t > 20:
			if not MoodleDisplay.has_moodle("parched"):
				MoodleDisplay.add_moodle("parched")
			MoodleDisplay.remove_moodle("overhydrated")
			MoodleDisplay.remove_moodle("slaked")
			MoodleDisplay.remove_moodle("thirsty")
			MoodleDisplay.remove_moodle("dehydrated")
			MoodleDisplay.remove_moodle("waterintoxicated")
			MoodleDisplay.remove_moodle("dessicated")
		elif t <= 20:
			if not MoodleDisplay.has_moodle("dessicated"):
				MoodleDisplay.add_moodle("dessicated")
			MoodleDisplay.remove_moodle("overhydrated")
			MoodleDisplay.remove_moodle("slaked")
			MoodleDisplay.remove_moodle("thirsty")
			MoodleDisplay.remove_moodle("dehydrated")
			MoodleDisplay.remove_moodle("parched")
			MoodleDisplay.remove_moodle("waterintoxicated")
		else:
			MoodleDisplay.remove_moodle("waterintoxicated")
			MoodleDisplay.remove_moodle("overhydrated")
			MoodleDisplay.remove_moodle("slaked")
			MoodleDisplay.remove_moodle("thirsty")
			MoodleDisplay.remove_moodle("dehydrated")
			MoodleDisplay.remove_moodle("parched")
			MoodleDisplay.remove_moodle("dessicated")

#main mood loop
func moodLoop() -> void:
	while true:
		await get_tree().create_timer(10).timeout


		mood += calcmood(1.0)
		#showly neutralize in lerp but im going to be honesst they basically do nothing

		mood = snappedf(mood, 0.01)


		mood = clamp(mood, minmood, maxmood)
		
		gbData.data.save.mood = mood
		if gbData.devMode:
			print(str("mood: ", mood))
			print(str("tick: ", calcmood(1.0)))
		if !gbData.settings["lobotomize"]:
			mood = 0.0
		_sync_mood()
		
		if mood > 50:
			$"%behavior".faceSys.setEmotion("happy")
		elif mood < -75:
			$"%behavior".faceSys.setEmotion("sad")
		else:
			$"%behavior".faceSys.setEmotion("normal")
		
		if mood > 80:
			if not MoodleDisplay.has_moodle("gleeful"):
				MoodleDisplay.add_moodle("gleeful")
			MoodleDisplay.remove_moodle("happy")
			MoodleDisplay.remove_moodle("excited")
			MoodleDisplay.remove_moodle("satisfied")
			MoodleDisplay.remove_moodle("sad")
			MoodleDisplay.remove_moodle("depressed")
			MoodleDisplay.remove_moodle("gloomy")
			MoodleDisplay.remove_moodle("miserable")
		elif mood > 50:
			if not MoodleDisplay.has_moodle("happy"):
				MoodleDisplay.add_moodle("happy")
			MoodleDisplay.remove_moodle("gleeful")
			MoodleDisplay.remove_moodle("excited")
			MoodleDisplay.remove_moodle("satisfied")
			MoodleDisplay.remove_moodle("sad")
			MoodleDisplay.remove_moodle("depressed")
			MoodleDisplay.remove_moodle("gloomy")
			MoodleDisplay.remove_moodle("miserable")
		elif mood > 30:
			if not MoodleDisplay.has_moodle("excited"):
				MoodleDisplay.add_moodle("excited")
			MoodleDisplay.remove_moodle("happy")
			MoodleDisplay.remove_moodle("gleeful")
			MoodleDisplay.remove_moodle("satisfied")
			MoodleDisplay.remove_moodle("sad")
			MoodleDisplay.remove_moodle("depressed")
			MoodleDisplay.remove_moodle("gloomy")
			MoodleDisplay.remove_moodle("miserable")
		elif mood > 10:
			if not MoodleDisplay.has_moodle("satisfied"):
				MoodleDisplay.add_moodle("satisfied")
			MoodleDisplay.remove_moodle("happy")
			MoodleDisplay.remove_moodle("excited")
			MoodleDisplay.remove_moodle("gleeful")
			MoodleDisplay.remove_moodle("sad")
			MoodleDisplay.remove_moodle("depressed")
			MoodleDisplay.remove_moodle("gloomy")
			MoodleDisplay.remove_moodle("miserable")
		elif mood < -10 and mood > -30:
			if not MoodleDisplay.has_moodle("sad"):
				MoodleDisplay.add_moodle("sad")
			MoodleDisplay.remove_moodle("happy")
			MoodleDisplay.remove_moodle("excited")
			MoodleDisplay.remove_moodle("satisfied")
			MoodleDisplay.remove_moodle("gleeful")
			MoodleDisplay.remove_moodle("depressed")
			MoodleDisplay.remove_moodle("gloomy")
			MoodleDisplay.remove_moodle("miserable")
		elif mood < -30 and mood > -50:
			if not MoodleDisplay.has_moodle("depressed"):
				MoodleDisplay.add_moodle("depressed")
			MoodleDisplay.remove_moodle("happy")
			MoodleDisplay.remove_moodle("excited")
			MoodleDisplay.remove_moodle("satisfied")
			MoodleDisplay.remove_moodle("sad")
			MoodleDisplay.remove_moodle("gleeful")
			MoodleDisplay.remove_moodle("gloomy")
			MoodleDisplay.remove_moodle("miserable")
		elif mood < -50 and mood > -75: 
			if not MoodleDisplay.has_moodle("gloomy"):
				MoodleDisplay.add_moodle("gloomy")
			MoodleDisplay.remove_moodle("happy")
			MoodleDisplay.remove_moodle("excited")
			MoodleDisplay.remove_moodle("satisfied")
			MoodleDisplay.remove_moodle("sad")
			MoodleDisplay.remove_moodle("depressed")
			MoodleDisplay.remove_moodle("gleeful")
			MoodleDisplay.remove_moodle("miserable")
		elif mood < -75:
			if not MoodleDisplay.has_moodle("miserable"):
				MoodleDisplay.add_moodle("miserable")
			MoodleDisplay.remove_moodle("happy")
			MoodleDisplay.remove_moodle("excited")
			MoodleDisplay.remove_moodle("satisfied")
			MoodleDisplay.remove_moodle("sad")
			MoodleDisplay.remove_moodle("depressed")
			MoodleDisplay.remove_moodle("gloomy")
			MoodleDisplay.remove_moodle("gleeful")
		else:
			MoodleDisplay.remove_moodle("gleeful")
			MoodleDisplay.remove_moodle("happy")
			MoodleDisplay.remove_moodle("excited")
			MoodleDisplay.remove_moodle("satisfied")
			MoodleDisplay.remove_moodle("sad")
			MoodleDisplay.remove_moodle("depressed")
			MoodleDisplay.remove_moodle("gloomy")
			MoodleDisplay.remove_moodle("miserable")
			
func calcmood(total: float):
	#health
	total -= clamp(((1.0 - (gbData.data.save["health"] * 0.01)) * 3), 0.0, 3)
	#hunger
	total -= clamp(((1.0 - (gbData.data.save["hunger"] * 0.01)) * 1), 0.0, 1)
	#trust
	total -= clamp(((1.0 - (gbData.data.save["trust"] * 0.01)) * 1), 0.0, 1)

	if gbData.data.save["trust"] >= 60.0:
		total += 0.25
	if gbData.data.save["hunger"] >= 85.0:
		total += 0.25
	#clamp to user settings
	total = clamp(total, minmood, maxmood)
	#undo all of it

	print(total)
	return total

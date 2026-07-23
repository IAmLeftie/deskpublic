extends Node

# Manages hunger and trust decay
"""

"""
@onready var data = gbData.data
@onready var settings = gbData.settings

var tRtick: float = 0


signal die()

signal hunger(hungry: int)
func _ready():
	await get_tree().create_timer(1).timeout
	$"%behavior".moveSys.maxspeed = 280.0
	lowerhunger()
	lowerthirst()
	trustcalc()
	

var foodstate = "normal"
var thirststate = "normal"

func lowerthirst():
	while true:
		await get_tree().create_timer(1.5).timeout
		gbData.data.save.thirst -= settings["hungerDecayRate"]
		
		var t = gbData.data.save.thirst
		
		if t > 175:
			thirststate = "waterintoxicated"
		elif t > 125:
			thirststate = "overhydrated"
		elif t > 100:
			thirststate = "slaked"
		elif t <= 75 and t > 55:
			thirststate = "thirsty"
		elif t <= 55 and t > 35:
			thirststate = "dehydrated"
		elif t <= 35 and t > 20:
			thirststate = "parched"
		elif t <= 20:
			thirststate = "dessicated"
		else:
			thirststate = "normal"
			
		match thirststate:
			"waterintoxicated":
				$"%behavior".moodSys.maxspeed -= 40.0
				gbData.data.save.health -= 0.5
			"overhydrated":
				$"%behavior".moodSys.maxspeed -= 40.0
			_: pass

func lowerhunger():
	while true:
		await get_tree().create_timer(3.0).timeout
		gbData.data.save.hunger -= settings["hungerDecayRate"]
		
		var h = gbData.data.save.hunger
		
		if h > 120:
			foodstate = "full"
		elif h > 100:
			foodstate = "satiated"
		elif h < 75 and h > 50:
			foodstate = "peckish"
		elif h < 50 and h > 35:
			foodstate = "hungry"
		elif h < 35 and h > 15:
			foodstate = "veryhungry"
		elif h <= 15:
			foodstate = "starving"
		else:
			foodstate = "normal"
			
		match foodstate:
			"normal", "peckish", "hungry":
				pass
			"full":
				$"%behavior".moveSys.maxspeed -= 80.0
			"satiated":
				$"%behavior".moveSys.maxspeed -= 40.0
			"veryhungry":
				gbData.data.save.health -= 0.05
			"starving":
				gbData.data.save.health -= 0.1
			
		
		#if h >= 60: hungry = false
		#if h >= 30: starved = false
		#
		#if h < 60 and not hungry:
			#hungry = true
			#hunger.emit(h)
			#print("hungry")
#
		#
		#if h < 30 and not starved:
			#starved = true
			#hunger.emit(h)
			#print("starved")
#
		#if hungry:
			#gbData.data.save["health"] -= .05
		#if starved:
			#gbData.data.save["health"] -= .1

		print(h)


func trustcalc():
		while true:
			await get_tree().create_timer(10).timeout
			

			var moodfactor = data.save.mood / 100.0
			var hungerfactor = (data.save.hunger - 100.0) / 100.0
			var thirstfactor
			if data.save.thirst > 175:
				thirstfactor = 0
			else:
				thirstfactor = (data.save.thirst - 100.0) / 100.0
			var healthfactor = (data.save.health - 100.0) / 100.0
			

			tRtick = (moodfactor * 0.5) + (hungerfactor * 0.3) + (healthfactor * 0.2) + (thirstfactor * 0.3)
			tRtick *= 3
			if foodstate == "starving":
				tRtick -= 0.5
			elif foodstate == "veryhungry":
				tRtick -= 0.35
			elif foodstate == "hungry":
				tRtick -= 0.2
			
			data.save.trust = clamp(data.save.trust + tRtick, 0.0, 100.0)
			
			if gbData.devMode:
				print("tRtick: ", tRtick)
				print("trust: ", data.save.trust)

		
func normalize_value(val: float, min_val: float, max_val: float) -> float:
	if max_val == min_val:
		return 0.0 # Prevent division by zero error
	return (val - min_val) / (max_val - min_val)

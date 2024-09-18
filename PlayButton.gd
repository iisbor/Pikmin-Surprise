extends Node2D

@onready var clock = get_node("%Timer")
@onready var button = get_node("%Button")
@onready var pikminHeardLB = get_node("%Pikmin_HeardLB")
@onready var clockLB = get_node("%ClockLB")
@onready var eventManager = get_node("%EventManager")
@onready var pikminScene = preload("res://pikmin_effect.tscn")

var second =  0
var minute = 0
var hour = 0
var day = 0
var pikminHeard = 0
var frame = 0

var ranGen = RandomNumberGenerator.new()

func _process(delta):
	second = abs(60 - clock.get_time_left())
	clockLB.text = str(day) + ":" + str(hour) + ":" + str(minute) + ":" + str(int(second)) 
	
	frame += 1
	if frame == 60:
		frame = 0
		randomGen()
	
# Starts the timer and event-manager
func _on_pressed():
	print("Pressed")
	clock.start()
	
	button.visible = false
	pikminHeardLB.visible = true
	clockLB.visible = true
	
	pikminPlay()

func _on_timer_timeout():
	minute += 1
	if minute == 60:
		hour += 1
		minute = 0
	if hour == 24:
		day += 1
		hour = 0

func pikminPlay():
	pikminHeard += 1
	pikminHeardLB.text = "Pikmin Heard	:	" + (str)(pikminHeard)
	var pikminSound = pikminScene.instantiate()
	eventManager.add_child(pikminSound)
	
func randomGen():
	var randPick = ranGen.randi_range(1,180)
	if randPick == 1:
		pikminPlay()
	

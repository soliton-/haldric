extends Control

onready var flag_item = $HBoxContainer/Flag as SidePanelItem
onready var gold_item = $HBoxContainer/Gold as SidePanelItem
onready var villages_item = $HBoxContainer/Villages as SidePanelItem
onready var units_item = $HBoxContainer/Units as SidePanelItem
onready var upkeep_item = $HBoxContainer/Upkeep as SidePanelItem
onready var income_item = $HBoxContainer/Income as SidePanelItem
onready var battery_item = $HBoxContainer/Battery as SidePanelItem
onready var time_item = $HBoxContainer/Time as SidePanelItem

func _process(delta):
	time_item.set_text(_get_time_string())
	battery_item.set_text( "%d%s" % [OS.get_power_percent_left(), "%"])
	if OS.get_power_percent_left() == -1:
		battery_item.hide()

func update_side(scenario : Scenario, side : Side) -> void:
	flag_item.texture_rect.material = side.flag_shader
	flag_item.set_text(str(side.side))
	gold_item.set_text(str(side.gold))
	units_item.set_text(str(side.units.get_child_count()))
	upkeep_item.set_text(str(side.upkeep))
	villages_item.set_text( "%d/%d" % [side.villages.size(), scenario.get_village_count()] )
	income_item.set_text(str(side.income))


func _get_time_string() -> String:
	var time = OS.get_time()
	var hour = time.hour
	var minute = time.minute
	return "%s : %s" % [str(hour).pad_zeros(2), str(minute).pad_zeros(2)]
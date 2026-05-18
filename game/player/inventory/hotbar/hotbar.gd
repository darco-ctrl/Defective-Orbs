extends Control
class_name Hotbar


@export var inventory_data: InventoryData

@export var test_potion: PotionData

func _ready() -> void:
	fill_slots()
	add_potion(test_potion)

func add_potion(potion_data: PotionData) -> void:
	for slot in inventory_data.slots:
		if slot.slot_data.potion_data: continue

		slot.set_potion(potion_data)
		return

func fill_slots() -> void:

	if inventory_data.slots:
		for slot in inventory_data.slots:
			slot.queue_free()

	inventory_data.slots.resize(inventory_data.max_slots)
	for i in range(inventory_data.max_slots):
		var pos: Vector2 = position

		var slot = inventory_data.slot_scene.instantiate() as Slot
		slot.name = "slot_" + str(i)
		slot.create_slot_data()
		slot.update_slot()

		inventory_data.slots[i] = slot
		add_child(slot)

		position = pos

	

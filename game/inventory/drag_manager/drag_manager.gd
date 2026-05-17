extends Control
class_name  DragManager

@export var drag_icon: TextureRect

var slot_data: SlotData

func _ready() -> void:
	GlobalInventoryAccess.drag_manager = self

func _process(_delta: float) -> void:
	if slot_data:
		update_position()

func update_position() -> void:
	var mouse_pos = get_global_mouse_position()
	drag_icon.position = mouse_pos

func slot_clicked(slot: Slot) -> void:
	if slot_data:
		if slot.is_empty(): return

		slot_data = slot.slot_data.duplicate()
		slot.free_slot()

	else:
		var origin_slot: Slot = slot_data.source_slot
		origin_slot.slot_data = slot.slot_data
		slot.slot_data = slot_data
		slot_data = null

func update() -> void:
	if slot_data:
		drag_icon.texture = slot_data.potion_data.icon
	else:
		drag_icon.texture = null
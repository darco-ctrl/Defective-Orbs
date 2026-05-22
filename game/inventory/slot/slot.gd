extends Control
class_name  Slot

@export var item_icon: TextureRect

var slot_data: SlotData
var current_drag_data: SlotData

func create_slot_data() -> void:
	slot_data = SlotData.new()

	slot_data.source_slot = self

func set_potion(potion_data: OrbData) -> bool:
	var is_add_item_successful: bool = false
	if slot_data:
		slot_data.potion_data = potion_data
		is_add_item_successful = true

		update_slot()

	return is_add_item_successful

func update_slot() -> void:
	var is_slot_empty = not slot_data.potion_data
	if is_slot_empty:
		free_slot()
	else:
		item_icon.texture = slot_data.potion_data.icon

func free_slot() -> void:
	slot_data.potion_data = null
	item_icon.texture = null

func _get_drag_data(_at_position: Vector2) -> Variant:
	if is_empty(): return
	var drag_data: SlotData = SlotData.new()
	drag_data.source_slot = self
	drag_data.potion_data = slot_data.potion_data

	slot_data.clear_item()

	update_slot()

	var preview = TextureRect.new()
	preview.custom_minimum_size = Vector2(64.0, 64.0)
	preview.size = Vector2(64.0, 64.0)

	preview.texture = drag_data.potion_data.icon
	set_drag_preview(preview)

	current_drag_data = drag_data
	return drag_data

func _notification(what: int) -> void:
	if what != NOTIFICATION_DRAG_END:
		return

	if current_drag_data == null:
		return

	if not is_drag_successful():
		var source_slot = current_drag_data.source_slot
		source_slot.set_slot_data(current_drag_data)
		source_slot.update_slot()

	current_drag_data = null

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	var drag_data: SlotData = data as SlotData
	if drag_data:
		return true

	return false

func swap_slot(source_slot: Slot, drag_slot_data: SlotData) -> void:
	var temp_slot_data: SlotData = slot_data

	set_slot_data(drag_slot_data)
	source_slot.set_slot_data(temp_slot_data)

	current_drag_data = null
	update_slot()
	source_slot.update_slot()


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var drag_slot_data: SlotData = data as SlotData
	if not drag_slot_data: return

	var source_slot: Slot = drag_slot_data.source_slot
	if source_slot == self: 
		slot_data = drag_slot_data

		update_slot()
	else:
		swap_slot(source_slot, drag_slot_data)

func set_slot_data(new_slot_data: SlotData) -> void:
	slot_data = new_slot_data
	slot_data.source_slot = self

func is_empty() -> bool:
	if slot_data.potion_data: return false
	else: return true

func slot_interacted() -> void:
	if not slot_data.potion_data: return

	var player: Player = GlobalInventoryAccess.player_inventory.player
	var potion_data: OrbData = slot_data.potion_data
	free_slot()

	var potion: OrbBase = potion_data.orb_scene.instantiate()
	potion.player = player
	potion.orb_data = potion_data

	player.potions.add_child(potion)

func _on_gui_input(event: InputEvent) -> void:
	var mouse_event: InputEventMouseButton = event as InputEventMouseButton
	if mouse_event and mouse_event.is_pressed():
		if mouse_event.button_index == MOUSE_BUTTON_RIGHT:
			slot_interacted()
		

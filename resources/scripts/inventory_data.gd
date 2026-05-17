extends Resource
class_name InventoryData

@export var id: String
@export var max_slots: int
@export var slot_scene: PackedScene

var slots: Array[Slot]
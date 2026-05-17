extends Resource

class_name SlotData

var source_slot: Slot
var potion_data: PotionData

func clear_item() -> void:
    potion_data = null

func clear() -> void:
    source_slot = null
    potion_data = null
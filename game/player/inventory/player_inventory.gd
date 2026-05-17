extends Control
class_name  PlayerInventory

@export var hotbar: Hotbar
@export var player: Player

func _ready() -> void:
	GlobalInventoryAccess.player_inventory = self




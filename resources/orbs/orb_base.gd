extends Node
class_name OrbBase

@export var orb_data: OrbData

var active: bool = false

var player: Player

func _ready() -> void: pass
func _process(_delta: float) -> void: pass

func activate() -> void:
    OrbManager.set_orb(orb_data.orb_type)
    active = true

func diactivate() -> void:
    OrbManager.clear_orb()
    active = false



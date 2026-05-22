extends Node

var current_active_orb: OrbTypes.Orb = OrbTypes.Orb.NONE

func set_orb(orb_type: OrbTypes.Orb) -> void:
    current_active_orb = orb_type

func clear_orb() -> void:
    current_active_orb = OrbTypes.Orb.NONE
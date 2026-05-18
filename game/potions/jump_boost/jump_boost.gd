extends Potion

func _ready() -> void:
	player.jump_power = 2

func _on_timer_timeout() -> void:
	player.jump_power = 1
	queue_free()
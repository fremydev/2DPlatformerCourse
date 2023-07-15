extends Camera2D

var target_position: Vector2 = Vector2.ZERO
@export var background_color: Color


func _ready():
	RenderingServer.set_default_clear_color(background_color)
	
	
func _process(delta):
	acquire_target_position()
	
	global_position = lerp(target_position, global_position, pow(2, -15 * delta))


func acquire_target_position() -> void:
	var players: Array[Node] = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player: Node = players[0]
		target_position = player.global_position

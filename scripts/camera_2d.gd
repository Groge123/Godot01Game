extends Camera2D


var speed=10
func _ready() -> void:
    
    position=GlobalData.cur_Player.position

func _process(delta: float) -> void:
    #var velocity=(player.position-position).normalized()
    #position+=velocity*speed*delta
    #print("position=",position)
    position=GlobalData.cur_Player.position

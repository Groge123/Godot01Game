extends CanvasLayer

class_name ExitDialog

func _ready() -> void:
    hide()

func _process(delta: float) -> void:
    if visible:
        get_tree().paused=true
        


func _on_comfirm_pressed() -> void:
    get_tree().quit()
    show()

func _on_cancel_pressed() -> void:
    visible=false
    get_tree().paused=false

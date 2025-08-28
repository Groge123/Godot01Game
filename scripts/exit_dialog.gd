extends CanvasLayer

class_name ExitDialog

@onready var anim: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
    hide()
    connect("visibility_changed", Callable(self, "_on_visibility_changed"))

func _on_visibility_changed() -> void:
    if visible :
        get_tree().paused = true
        anim.play("fade_in")

func _on_comfirm_pressed() -> void:
    anim.play("fade_out")
    await anim.animation_finished
    get_tree().quit()
    show()

func _on_cancel_pressed() -> void:
    anim.play("fade_out")
    await anim.animation_finished
    hide()
    get_tree().paused=false

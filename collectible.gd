extends Area2D

func _ready():
	$AnimatedSprite2D.play("default")
	
func _on_body_entered(body):
	
	if body.name == "Player": 

		$AudioStreamPlayer.play()

		$AnimatedSprite2D.hide()
		set_deferred("monitoring", false)
		
		# 4. Tunggu sampai suara "ding" selesai, baru hapus objeknya dari dunia [cite: 1130]
		await $AudioStreamPlayer.finished
		queue_free()

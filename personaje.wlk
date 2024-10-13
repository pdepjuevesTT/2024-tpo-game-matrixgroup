import constantes.*

object jugador {
	var property position = game.center()
	var property image = "jugador.png"
	
	method moverseArriba() {
		position = if ((position.y() + 1) > 17) position else position.up(1)
		image = "jugador_back.png"
	}
	
	method moverseAbajo() {
		position = if ((position.y() - 1) < 0) position else position.down(1)
		image = "jugador.png"
	}
	
	method moverseIzquierda() {
		position = if ((position.x() - 1) < 0) position else position.left(1)
		image = "jugador_left.png"
	}
	
	method moverseDerecha() {
		position = if ((position.x() + 1) > 29) position else position.right(1)
		image = "jugador_right.png"
	}
}
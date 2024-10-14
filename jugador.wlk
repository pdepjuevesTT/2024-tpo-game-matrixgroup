import utiles.*
import computadora.computadora

object jugador {
	var property position = game.center()
	var property image = "jugador_frente.png"
	var property dinero = 14000
	
	method aumentarDinero(monto) {
		dinero += monto
	}
	
	method moverseArriba() {
		position = if (((position.y() + 1) > 7) || celdasOcupadas.estaOcupada(
		           		position.up(1)
		           	)) position
		           else position.up(1)
		image = "jugador_atras.png"
	}
	
	method moverseAbajo() {
		position = if (((position.y() - 1) < 0) || celdasOcupadas.estaOcupada(
		           		position.down(1)
		           	)) position
		           else position.down(1)
		image = "jugador_frente.png"
	}
	
	method moverseIzquierda() {
		position = if (((position.x() - 1) < 0) || celdasOcupadas.estaOcupada(
		           		position.left(1)
		           	)) position
		           else position.left(1)
		image = "jugador_izquierda.png"
	}
	
	method moverseDerecha() {
		position = if (((position.x() + 1) > 19) || celdasOcupadas.estaOcupada(
		           		position.right(1)
		           	)) position
		           else position.right(1)
		image = "jugador_derecha.png"
	}
}

object plata {
	method position() = game.center().right(8).down(5)
	
	method text() = jugador.dinero().toString() + " $"
	
	method textColor() = "00FF00FF"
}

object silla {
	var property position = computadora.position().down(1)
	
	method image() = "silla.png"
}
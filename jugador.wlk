import escena.*
import utiles.*
import computadora.*
import elementos.*
import tienda.*
import constantes.*
import empleado.*

object jugador {
	var property position = game.center()
	var property image = "jugador_frente.png"
	var property empleados = []
	var property sacoProducto = false
	var property barraProgresoProgramando = new BarraProgreso(
		position = computadora.position().up(2),
		listaAssets = listaAssetsBarra.reverse()
	)
	
	// -------------------- PROGRAMACION
	method programar() {
		//Arranca la cuenta regresiva cuando aprieta la E para programar
		if (position == computadora.silla().position()) {
			game.onTick(
				2000,
				"Evento de progreso de Codigo",
				{ self.resultadoProgramar() }
			)
			if (barraProgresoProgramando.finalizo()) barraProgresoProgramando.reiniciar()
		}
	}
	
	method entregarProducto() {
		if ((position == mostradorU.position().right(1).up(1)) && sacoProducto) {
			producto.position(mostradorU.position().right(1))
			producto.colocarProducto()
			sacoProducto = false
		}
	}
	
	method sacaProducto() {
		if (position == producto.position().down(1)) producto.sacarProducto()
	}
	
	method resultadoProgramar() {
		barraProgresoProgramando.iniciar()
		if (barraProgresoProgramando.finalizo()) {
			//En este sector se agrega lo que tiene que pasar cuando termina de programar.
			sacoProducto = true
			producto.colocarProducto()
			game.removeTickEvent("Evento de progreso de Codigo")
			// Necesario para detener el loop
		}
	}
	
	// ---------- EMPLEADOS
	method cobrarEmpleados() {
		empleados.forEach({ empleado => empleado.cobrar() })
	}
	
	method initialize() {
		game.onTick(5000, "Cobrar empleados", { self.cobrarEmpleados() })
	}
	
	// ------------------- MOVIMIENTO
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
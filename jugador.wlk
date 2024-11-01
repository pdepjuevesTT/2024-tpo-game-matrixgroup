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
	var property dinero = 0
	var property intelecto = 0
	var property cont = 0
	var property empleados = []
	var property barraProgresoProgramando = new BarraProgreso(
		position = position.right(1),
		listaAssets = listaAssetsBarra.reverse()
	)

	// -------------------
	method aumentarDinero(monto) {
		dinero += monto
	}
	
	method aumentarIntelecto(monto) {
		intelecto += monto
	}
	
	method gastarDinero(monto) {
		dinero -= monto
	}
	
	method enTienda() = self.position() == entradaTienda.position()
	// Funcion para que el jugador programe
	
	method programar() {
		//Arranca la cuenta regresiva cuando aprieta la E para programar
		if (position == computadora.silla().position()) {
			game.onTick(
				2000,
				"Evento de progreso de Codigo",
				{ self.resultadoProgramar() }
			)
			if (barraProgresoProgramando.finalizoProgreso()) barraProgresoProgramando.reiniciarBarra()
				// Cuando termina la Barra, se encarga de volver a setear su contador en cero.
		}
	} 
	
	method resultadoProgramar() {
		barraProgresoProgramando.paciencia()
		if (barraProgresoProgramando.barraFinaliza()) {
			//En este sector se agrega lo que tiene que pasar cuando termina de programar.
			self.aumentarIntelecto(1)
			self.aumentarDinero(51)
			
			game.removeTickEvent("Evento de progreso de Codigo")
			// Necesario para detener el loop
		}
	} 
	
	method tienda() {
		if (self.enTienda()) {
			// Implementar logica de la tienda
		}
	}
	
 	method comprarEmpleados() {

			// Implementar logica pero sin carteles

			if (dinero >= 100) {
				self.gastarDinero(100)
				const compuEmpleado = new Computadora(
					image = "computadora.gif",
					position = game.at(3, 7)
				)
				game.addVisual(compuEmpleado)
				const empleado1 = new Empleado(position = game.at(3, 6), image = "jugador_atras.png", frente = "jugador_frente.png", atras = "jugador_atras.png", izquierda = "jugador_izquierda.png", derecha = "jugador_derecha.png", objetivo = game.at(3, 6))
				game.addVisual(empleado1)
				empleados.add(empleado1)
			} else {
				// Implementar logicas de que no tiene dinero
			}
		
	} 
	
	method cobrarEmpleados() {
		empleados.forEach({ empleado => empleado.cobrar() })
	}
	
	// -------------------- MEJORA
/* 	method mejoraJugador() {
		// se le pasa la lista de objetos de mejoras, pero viendolo bien, si quisieramos una lista de mejoras de otra cosa, necesitariamos otro contador
		listaDeMejorasPc.get(self.cont()).mejora()
		cont += 1
	} */
	
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

class NPC {
	var property position = game.origin()
	var property image
	var property frente
	var property atras
	var property izquierda
	var property derecha
	var property objetivo
	
	method llego() = position == objetivo
	
	method irse(condicion) {
		if (condicion) {
			objetivo = salidaTienda.position()
		}
	}
	
	method moverse() {
		const deltaPosX = objetivo.x() - position.x()
		const deltaPosY = objetivo.y() - position.y()
		
		if (deltaPosX > 0) {
			position = position.right(1)
			image = derecha
			return
		}
		if (deltaPosX < 0) {
			position = position.left(1)
			image = izquierda
			return
		}
		if (deltaPosY > 0) {
			position = position.up(1)
			image = atras
			return
		}
		if (deltaPosY < 0) {
			position = position.down(1)
			image = frente
			return
		}
		
		return
	}
}

class Mejora {
	var property requisitoParaMejora
	var property requisitoPosicionJugador
	var property numeroMejora
	var property listaMejoras
	var property objetoActual = listaMejoras.get(numeroMejora - 1)
	var property objetoNuevo = listaMejoras.get(numeroMejora)
	
	method mejora() {
		if (requisitoParaMejora.apply() && requisitoPosicionJugador.apply()) {
			game.removeVisual(objetoActual)
			game.addVisual(objetoNuevo)
		}
	}
} 

/* 
const mejora1 = new Mejora(
	numeroMejora = 1,
	listaMejoras = listaObjetosPc,
	requisitoParaMejora = { jugador.dinero() > 50 },
	requisitoPosicionJugador = { jugador.estaSentado() }
)

const mejora2 = new Mejora(
	numeroMejora = 2,
	listaMejoras = listaObjetosPc,
	requisitoParaMejora = { jugador.dinero() > 100 },
	requisitoPosicionJugador = { jugador.estaSentado() }
)
  */
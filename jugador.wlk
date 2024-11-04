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
	var property cont = 0
	
	var property empleados = []
	var property barraProgresoProgramando = new BarraProgreso(
		position = computadora.position().up(2),
		listaAssets = listaAssetsBarra.reverse()
	)

	method initialize() {
		game.onTick(5000, "Cobrar empleados", {self.cobrarEmpleados()})
	}
	
	method enTienda() = self.position() == entradaTienda.position()
	
	method programar() {
		//Arranca la cuenta regresiva cuando aprieta la E para programar
		if (position == computadora.silla().position()) {
			game.onTick(
				2000,
				"Evento de progreso de Codigo",
				{ self.resultadoProgramar() }
			)
			if (barraProgresoProgramando.finalizo()) barraProgresoProgramando.reiniciarBarra()
		}
	} 
	
	method resultadoProgramar() {
		barraProgresoProgramando.iniciar()
		if (barraProgresoProgramando.finalizo()) {
			//En este sector se agrega lo que tiene que pasar cuando termina de programar.
			intelecto.aumentar(1)
			dinero.aumentar(51)
			
			game.removeTickEvent("Evento de progreso de Codigo")
			// Necesario para detener el loop
		}
	} 
	
	method tienda() {
		if (self.enTienda()) {
			game.addVisual(dialogoGame)
			game.onTick(5000, "aparecer dialogo", {game.removeVisual(dialogoGame)})
		}
	}
	
 	method comprarEmpleados() {
			if (dinero.atributo() >= 100) {
				dinero.reducir(100)
				computadora.nuevaComputadora(0, 7)
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

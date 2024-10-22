import utiles.*
import computadora.*

object jugador {
	var property position = game.center()
	var property image = "jugador_frente.png"
	var property dinero = 0
	var property intelecto = 0
	var property cont = 0
	
	// -------------------
	method aumentarDinero(monto) {
		dinero += monto
	}
	
	method aumentarIntelecto(monto) {
		intelecto += monto
	}
	
	method estaSentado() = self.position() == silla.position()
	// Funcion para que el jugador programe
	
	method programar() {
		//Arranca la cuenta regresiva cuando aprieta la E para programar
		if (self.estaSentado()) {
			game.onTick(
				2000,
				"Evento de progreso de Codigo",
				{ self.resultadoProgramar() }
			)
			if (barraComputadora.barraFinaliza()) barraComputadora.reiniciarBarra()
				// Cuando termina la Barra, se encarga de volver a setear su contador en cero.
		}
	}
	
	method resultadoProgramar() {
		barraComputadora.paciencia(self.estaSentado())
		if (barraComputadora.barraFinaliza()) {
			//En este sector se agrega lo que tiene que pasar cuando termina de programar.
			self.aumentarIntelecto(1)
			self.aumentarDinero(51)
			
			game.removeTickEvent("Evento de progreso de Codigo")
			// Necesario para detener el loop
		}
	}
	
	// -------------------- MEJORA
	method mejoraJugador() {
		// se le pasa la lista de objetos de mejoras, pero viendolo bien, si quisieramos una lista de mejoras de otra cosa, necesitariamos otro contador
		listaDeMejorasPc.get(self.cont()).mejora()
		cont += 1
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
} // ---------------- NPC

class NPC {
	var property position = game.origin()
	var property image = "jugador_frente.png"
	var property frente
	var property atras
	var property izquierda
	var property derecha
	var property objetivo
	
	method llego() = position == objetivo
	
	method seVa() {
		if (barraCliente.barraFinaliza()) {
			objetivo = game.at(-1, 1)
		}
	}
	
	method mover() {
		if (!self.llego()) {
			if (position.x() < objetivo.x()) {
				position = position.right(1)
				image = derecha
			} else {
				if (position.x() > objetivo.x()) {
					position = position.left(1)
					image = izquierda
				} else {
					if (position.y() < objetivo.y()) {
						position = position.up(1)
						image = atras
					} else {
						if (position.y() > objetivo.y()) {
							position = position.down(1)
							image = frente
						}
					}
				}
			}
		}
		self.seVa()
	}
} //----------------------------------------------

object salida {
	method position() = game.at(-1, 1)
}

const cliente = new NPC(
	objetivo = game.at(5, 1),
	frente = "jugador_frente.png",
	atras = "jugador_atras.png",
	izquierda = "jugador_izquierda.png",
	derecha = "jugador_derecha.png"
)

//----------------------------------------------
// Texto contador de dinero del jugador
object plata {
	method position() = game.center().right(8).down(5)
	
	method text() = jugador.dinero().toString() + " $"
	
	method textColor() = "00FF00FF"
} // Texto contador de intelecto del jugador

object intelecto {
	method position() = game.center().right(9).down(5)
	
	method text() = jugador.intelecto().toString()
}

object silla {
	var property position = computadora.position().down(1)
	
	method image() = "silla.png"
}

const listaDeBarrasDescendente = [
	"barra1.png",
	"barra2.png",
	"barra3.png",
	"barra4.png",
	"barra4.png"
]

const listaDeBarrasAscendente = [
	"barra4.png",
	"barra3.png",
	"barra2.png",
	"barra1.png",
	"barra1.png"
]

class Barra {
	var property position
	var property image = 0
	var property contador = 0
	var property lista
	var property tamList = lista.size()
	
	method barraFinaliza() = contador == tamList
	
	// condicionInicioBarra es la posición del objeto en relación al personaje, puede ser por ejemplo cliente.llego() o jugador.estaSentado()
	method paciencia(condicionInicioBarra) {
		if (condicionInicioBarra && (contador < tamList)) {
			image = lista.get(contador)
			contador += 1
		}
		if (self.barraFinaliza()) game.removeVisual(self)
	}
	
	method reiniciarBarra() {
		game.removeVisual(self)
		self.contador(0)
		game.addVisual(self)
	}
}

const barraCliente = new Barra(
	position = game.at(6, 1),
	lista = listaDeBarrasDescendente
)

const barraComputadora = new Barra(
	position = game.at(5, 9),
	lista = listaDeBarrasAscendente
)

// MEJORAS
class Mejora {
	var property requisitoParaMejora
	// Por ejemplo, dinero del jugador > 50 e intelecto > 10
	var property requisitoPosicionJugador
	// Donde tiene que estar parado el jugador
	var property numeroMejora //Se coloca el numero de mejora para usarlo de indice
	var property listaMejoras
	/*se le pasa la lista de mejoras de un objeto, por ejemplo listaMejorasPc que tiene la pc base, la pc junior, la pc senior, etc...*/
	var property objetoActual = listaMejoras.get(numeroMejora - 1)
	var property objetoNuevo = listaMejoras.get(numeroMejora)
	
	method mejora() {
		if (requisitoParaMejora.apply() && requisitoPosicionJugador.apply()) {
			game.removeVisual(objetoActual)
			game.addVisual(objetoNuevo)
		}
	}
} // ----------------------------------------------

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

// ATENCION!! para agregar una mejora mas, hay que agregar otra imagen a listaObjetosPc
// --------------------------------------------
const listaObjetosPc = [computadora, computadora2, computadora3]

// Acá, y en orden hay que agregar los objetos que se van a ir mejorando
const listaDeMejorasPc = [mejora1, mejora2]
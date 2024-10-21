import utiles.*
import computadora.computadora

object jugador {
	var property position = game.center()
	var property image = "jugador_frente.png"
	var property dinero = 0
	var property intelecto = 0
	
	// -------------------
	method aumentarDinero(monto) {
		dinero += monto
	}

	method aumentarIntelecto(monto){
		intelecto += monto
	}

	method estaSentado() =self.position() == silla.position()

	// Funcion para que el jugador programe
	method programar() {
		//Arranca la cuenta regresiva cuando aprieta la E para programar
		if(self.estaSentado()){
			game.onTick(2000, "Evento de progreso de Codigo", {self.resultadoProgramar()})
			if(barraComputadora.barraFinaliza()){ 
			barraComputadora.reiniciarBarra() 
			// Cuando termina la Barra, se encarga de volver a setear su contador en cero.
			}
		}
	}

	method resultadoProgramar(){
		barraComputadora.paciencia(self.estaSentado())
		if(barraComputadora.barraFinaliza()){
				//En este sector se agrega lo que tiene que pasar cuando termina de programar.
				self.aumentarIntelecto(1)
				self.aumentarDinero(51)

				game.removeTickEvent("Evento de progreso de Codigo")// Necesario para detener el loop
				
				
			}
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
// ---------------- NPC
class NPC {
	var property position = game.origin()
	var property image = "jugador_frente.png"
	var property frente
	var property atras
	var property izquierda
	var property derecha
	var property objetivo
	
	method llego() = position == objetivo
	
	method seVa(){
		if(barraCliente.barraFinaliza()){ // Cuando se acaba la barra de paciencia desaparece
			game.removeVisual(self)
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
}
//----------------------------------------------
const cliente = new NPC(
		objetivo = game.at(5, 5),
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
}

// Texto contador de intelecto del jugador
object intelecto {
	method position() = game.center().right(9).down(5)
	method text() = jugador.intelecto().toString()

}

object silla {
	var property position = computadora.position().down(1)
	
	method image() = "silla.png"
}

const listaDeBarrasDescendente = ["barra1.png","barra2.png","barra3.png","barra4.png", "barra4.png"]
const listaDeBarrasAscendente = ["barra4.png","barra3.png","barra2.png","barra1.png","barra1.png"]
class Barra{
	var property position
	var property image = 0
	var property contador = 0
	var property lista
	var property tamList = lista.size() 

	method barraFinaliza() = contador == tamList // momento donde llega hasta la última imagen.

	// condicionInicioBarra es la posición del objeto en relación al personaje, puede ser por ejemplo cliente.llego() o jugador.estaSentado()
	method paciencia(condicionInicioBarra){
		if(condicionInicioBarra && contador < tamList	){
	
			image = lista.get(contador)
			contador += 1
		}
		if(self.barraFinaliza()){
			
			game.removeVisual(self)
		}
	}
	
		method reiniciarBarra(){
			game.removeVisual(self)
			self.contador(0)
			game.addVisual(self)
		}


	}

const barraCliente = new Barra(position = game.at(6,5), lista = listaDeBarrasDescendente)
const barraComputadora = new Barra(position = game.at(5,9), lista = listaDeBarrasAscendente)

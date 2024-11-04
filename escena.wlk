import jugador.*
import utiles.*
import elementos.*
import tienda.*
import cliente.*
import computadora.*
import constantes.*

class Escena {
  const property visuales = []
  const property celdasBloqueadas = []
  
  method cargarEscena() {
    visuales.forEach({ visual => game.addVisual(visual) }) // Carga visuales
    
    celdasBloqueadas.forEach({ celda => celdasOcupadas.ocupar(celda) })
    // Carga celdas bloqueadas
  }
  
  method eliminarEscena() {
    visuales.forEach({ visual => game.removeVisual(visual) })
    celdasBloqueadas.forEach({ celda => celdasOcupadas.desocupar(celda) })
  }
}

const oficina = new Escena(
  visuales = [
    jugador,
    computadora,
    dinero,
    intelecto,
    mostradorU,
    cliente,
    tienda,
    entradaTienda
  ],
  celdasBloqueadas = [computadora.position(), tienda.position()]
)

const portada = new Escena(visuales = [portadaG], celdasBloqueadas = [])
import jugador.*
import utiles.*
import computadora.*
import elementos.*

class Escena {
  const property visuales
  
  method cargarVisuales() {
    visuales.forEach({ visual => game.addVisual(visual) })
  }
  
  method eliminarVisuales() {
    visuales.forEach({ visual => game.removeVisual(visual) })
  }
}


const oficina1 = new Escena(visuales = [jugador, computadora, plata, 
silla, intelecto, mostrador, cliente, barraCliente, barraComputadora, salida])
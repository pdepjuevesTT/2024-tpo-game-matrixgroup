import jugador.*
import utiles.*
import elementos.*
import tienda.*
import cliente.*
import computadora.*
import constantes.*

class Escena {
  const property visuales = []
  const property onTicks = []
  const property celdasBloqueadas = []
  
  method cargarEscena() {
    visuales.forEach({ visual => game.addVisual(visual) }) // Carga visuales
    
    onTicks.forEach(
      { ontick => game.onTick(
          ontick.intervalo(),
          ontick.nombre(),
          ontick.accion()
        ) }
    ) // Carga onTicks
    
    celdasBloqueadas.forEach({ celda => celdasOcupadas.ocupar(celda) })
    // Carga celdas bloqueadas
  }
  
  method eliminarEscena() {
    visuales.forEach({ visual => game.removeVisual(visual) })
    onTicks.forEach({ ontick => game.removeTickEvent(ontick.nombre()) })
    celdasBloqueadas.forEach({ celda => celdasOcupadas.desocupar(celda) })
  }
  
  method cambiarEscena(escenaNueva) {
    self.eliminarEscena()
    escenaNueva.cargarEscena()
  }
}

class OnTick {
  const property intervalo
  const property nombre
  const property accion
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
    entradaTienda,
    vida
  ],
  onTicks = [
    new OnTick(
      intervalo = 500,
      nombre = "cliente",
      accion = { cliente.comprar() }
    ),
    new OnTick(
      intervalo = 5000,
      nombre = "Cobrar empleados",
      accion = { jugador.cobrarEmpleados() }
    )
  ],
  celdasBloqueadas = [computadora.position(), tienda.position()]
)

const portada = new Escena(visuales = [portadaG], celdasBloqueadas = [])
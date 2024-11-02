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
    // Carga visuales
    visuales.forEach({ visual => game.addVisual(visual) })
    
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
    plata,
    intelecto,
    mostradorU,
    cliente,
    tienda,
    entradaTienda,
    salidaTienda
  ],
  onTicks = [
    new OnTick(
      intervalo = 500,
      nombre = "cliente",
      accion = { cliente.moverse() }
    ),
    new OnTick(
      intervalo = 5000,
      nombre = "Cobrar empleados",
      accion = { jugador.cobrarEmpleados() }
    )
  ],
  celdasBloqueadas = [computadora.position(), tienda.position()]
)

const portada = new Escena(
  visuales = [portadaG],
  onTicks = [],
  celdasBloqueadas = []
)
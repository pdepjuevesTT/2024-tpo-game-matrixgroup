import jugador.*
import utiles.*
import computadora.*
import elementos.*

class Escena {
  const property visuales
  const property onTicks
  const property celdasBloqueadas
  
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

const oficina1 = new Escena(
  visuales = [
    jugador,
    computadora,
    plata,
    silla,
    intelecto,
    mostrador,
    cliente,
    barraCliente,
    barraComputadora,
    salida
  ],
  onTicks = [
    new OnTick(
      intervalo = 500,
      nombre = "cliente",
      accion = { cliente.mover() }
    ),
    new OnTick(
      intervalo = 2000,
      nombre = "Barra",
      accion = { barraCliente.paciencia(cliente.llego()) }
    )
  ],
  celdasBloqueadas = [computadora.position()]
)
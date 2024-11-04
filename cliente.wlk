import constantes.*
import jugador.NPC
import elementos.BarraProgreso

class Cliente inherits NPC (
  image = "jugador_frente.png",
  objetivo = celdaCompra,
  frente = "jugador_frente.png",
  atras = "jugador_atras.png",
  izquierda = "jugador_izquierda.png",
  derecha = "jugador_derecha.png"
) {
  var property barraProgreso = new BarraProgreso(
    position = celdaCompra.right(1),
    listaAssets = listaAssetsBarra
  )
  
  method comprar() {
    if (!self.llego()) self.moverse()
    
    if (self.llego() && (objetivo == celdaCompra)) {
      barraProgreso.iniciar()
      
      if (barraProgreso.finalizo()) {
        objetivo = salidaCliente
        barraProgreso.reiniciar()
        game.removeVisual(barraProgreso)
      }
    }
    
    if (self.llego() && (objetivo == salidaCliente)) game.schedule(
        6000,
        { 
          position = entradaCliente
          objetivo = celdaCompra
        }
      )
  }
}

const cliente = new Cliente(
  image = "jugador_frente.png",
  objetivo = game.at(6, 1),
  frente = "jugador_frente.png",
  atras = "jugador_atras.png",
  izquierda = "jugador_izquierda.png",
  derecha = "jugador_derecha.png"
)
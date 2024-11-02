import constantes.*
import jugador.NPC
import elementos.BarraProgreso

class Cliente inherits NPC (
  image = "jugador_frente.png",
  objetivo = game.at(6, 1),
  frente = "jugador_frente.png",
  atras = "jugador_atras.png",
  izquierda = "jugador_izquierda.png",
  derecha = "jugador_derecha.png"
) {
  var property barraProgreso = new BarraProgreso(
    position = objetivo.right(1),
    listaAssets = listaAssetsBarra
  )
  
  override method moverse() {
    if (self.llego() && barraProgreso.finalizo()) {
      self.irse(true)
      game.removeVisual(barraProgreso)
    }
    
    if (self.llego() && (objetivo != salidaTienda.position()))
      barraProgreso.iniciarBarra()
    
    
    super()
    return
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
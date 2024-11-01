import jugador.*

class Empleado inherits NPC (
  image = "jugador_atras.png",
  frente = "jugador_frente.png",
  atras = "jugador_atras.png",
  izquierda = "jugador_izquierda.png",
  derecha = "jugador_derecha.png"
) {
  method initialize() {
    position = game.at(3, 6)
  }
  
  method cobrar() {
    jugador.aumentarDinero(50)
  }
}
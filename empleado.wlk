import jugador.*
import elementos.*
import npc.*

class Empleado inherits NPC (
  image = "jugador_atras.png",
  frente = "jugador_frente.png",
  atras = "jugador_atras.png",
  izquierda = "jugador_izquierda.png",
  derecha = "jugador_derecha.png"
) {
  method initialize() {
    
  }
  
  method cobrar() {
    dinero.aumentar(25)
  }
}
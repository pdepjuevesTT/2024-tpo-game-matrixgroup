import utiles.*
import inicio.*
import escena.*
import empleado.*
import tienda.*
import elementos.*
import constantes.*
import jugador.*

class Computadora {
  var property position
  var property image
  var property silla
  
  method initialize() {
    silla = new Silla(position = self.position().down(1))
    game.addVisual(silla)
  }
  
  method nuevaComputadora(posX, posY) {
    if (!oficina.celdasBloqueadas().contains(game.at(posX, posY))) {
      if (posX > 20) {
        game.addVisual(dialogoLimite)
        game.onTick(4000, "Limite", { game.removeVisual(dialogoLimite) })
        dinero.aumentar(100)
        return
      }
      const compu = new Computadora(
        position = game.at(posX, posY),
        image = "computadora.gif"
      )
      
      const empleadoN = new Empleado(
        position = game.at(posX, posY - 1),
        image = "jugador_atras.png",
        frente = "jugador_frente.png",
        atras = "jugador_atras.png",
        izquierda = "jugador_izquierda.png",
        derecha = "jugador_derecha.png",
        objetivo = game.at(posX, posY - 1)
      )
      
      game.addVisual(compu)
      game.addVisual(empleadoN)
      oficina.celdasBloqueadas().add(compu.position())
      return
    } else {
      self.nuevaComputadora(posX + 1, posY)
    }
  }
}

class Silla {
  var property position
  
  method image() = "silla.png"
}

const computadora = new Computadora(
  position = game.at(6, 7),
  image = "computadora.gif"
)
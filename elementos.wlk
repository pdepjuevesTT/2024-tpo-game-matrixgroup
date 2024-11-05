import utiles.celdasOcupadas
import jugador.jugador

object mostradorU {
  var property position = game.at(5, 2)
  
  method image() = "mostrador.png"
  
  method initialize() {
    celdasOcupadas.ocupar(position)
    celdasOcupadas.ocupar(position.right(1))
    celdasOcupadas.ocupar(position.up(1))
    celdasOcupadas.ocupar(position.right(2))
    celdasOcupadas.ocupar(position.right(2).up(1))
  }
}

class BarraProgreso {
  var property position
  var property image
  var property listaAssets
  var property progreso = 0
  var property limite
  
  method initialize() {
    limite = listaAssets.size() - 1
    image = listaAssets.get(progreso)
  }
  
  method finalizo() = progreso == limite
  
  method paciencia() {
    if (self.finalizo()) game.removeVisual(self)
    else game.schedule(
        2000,
        { 
          progreso += 1
          image = listaAssets.get(progreso)
        }
      )
  }
  
  method iniciar() {
    if (game.hasVisual(self)) self.paciencia() else game.addVisual(self)
  }
  
  method reiniciar() {
    progreso = 0
    image = listaAssets.get(progreso)
  }
}

class Aumento {
  var property atributo = 0
  
  method aumentar(monto) {
    atributo += monto
  }
  
  method reducir(monto) {
    atributo -= monto
  }
}

object vida inherits Aumento (atributo = 3) {
  var property image = "corazon3.png"
  
  method position() = game.center().right(6).down(5)
  
  override method reducir(monto) {
    atributo -= monto
    if (atributo > 0) {
      image = ("corazon" + atributo) + ".png"
    }
  }
  
  method perder() {
    if (atributo == 0) game.stop()
      // habría que manejar el cambio de escena a la pantalla de perdida.
  }
}

object dinero inherits Aumento {
  method position() = game.center().right(8).down(5)
  
  method text() = atributo.toString() + " $"
  
  method textColor() = "00FF00FF"
}

object intelecto inherits Aumento {
  method position() = game.center().right(9).down(5)
  
  method text() = atributo.toString()
}

class Imagen {
  const property position
  const property image
}

const portadaG = new Imagen(position = game.origin(), image = "inicioG.png")

const dialogoGame = new Imagen(position = game.at(8, 8), image = "dialogoG.png")

const dialogoLimite = new Imagen(
  position = game.at(8, 8),
  image = "limitecompra.png"
)
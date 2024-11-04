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
  
  method progresar() {
    game.schedule(3000, {   progreso += 1image = listaAssets.get(progreso)})
  }
  
  method iniciar() {
    if (game.hasVisual(self)) self.progresar() else game.addVisual(self)
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

object dinero inherits Aumento {
  method position() = game.center().right(8).down(5)
  
  method text() = atributo.toString() + " $"
  
  method textColor() = "00FF00FF"
}

object intelecto inherits Aumento {
  method position() = game.center().right(9).down(5)
  
  method text() = atributo.toString()
}

object portadaG {
  const property position = game.origin()
  const property image = "inicioG.png"
}
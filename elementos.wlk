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
  
  method iniciarBarra() {
    if (game.hasVisual(self)) self.paciencia() else game.addVisual(self)
  }
  
  method reiniciarBarra() {
    progreso = 0
    image = listaAssets.get(progreso)
  }
}

object plata {
  method position() = game.center().right(8).down(5)
  
  method text() = jugador.dinero().toString() + " $"
  
  method textColor() = "00FF00FF"
}

object intelecto {
  method position() = game.center().right(9).down(5)
  
  method text() = jugador.intelecto().toString()
}

object portadaG{
  const property position = game.origin()
  const property image = "inicioG.png"
}

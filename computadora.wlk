import inicio.*

class Computadora {
  var property position
  var property image
  var property silla
  
  method initialize() {
    silla = new Silla(position = self.position().down(1))
    game.addVisual(silla)
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
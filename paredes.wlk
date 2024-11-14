class Pared {
  var property position
  
  method dibujar() {
    game.addVisual(self)
  }
  
  method image() = "pared2.png"
}

class ParedInvertida inherits Pared {
  override method image() = "pared_invertida2.png"
}
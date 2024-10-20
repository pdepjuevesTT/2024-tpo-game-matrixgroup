class Mostrador {
  var property position
  var property izquierda
  var property derecha
  var property celdaAtencion
  
  method image() = "bloque_mostrador.png"
  
  method initialize() {
    izquierda = new BloqueMostrador(position = position.left(1))
    derecha = new BloqueMostrador(position = position.right(1))
    celdaAtencion = new BloqueInvisible(position = position.down(1))
    game.addVisual(izquierda)
    game.addVisual(derecha)
    game.addVisual(celdaAtencion)
    
    game.onCollideDo(
      celdaAtencion,
      { cliente => console.println("Atendiendo cliente: " + cliente) }
    )
  }
}

class BloqueMostrador {
  var property position
  
  method image() = "bloque_mostrador.png"
}

class BloqueInvisible {
  var property position
}
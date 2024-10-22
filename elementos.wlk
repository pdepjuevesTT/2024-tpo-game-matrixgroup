import utiles.celdasOcupadas

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
    
    celdasOcupadas.ocupar(position)
    celdasOcupadas.ocupar(izquierda.position())
    celdasOcupadas.ocupar(derecha.position())
    
    game.onCollideDo(
      celdaAtencion,
      { cliente => console.println("Atendiendo cliente: " + cliente) }
    )
  }

  // No esta controlado el caso en el que se cambie la posicion del mostrador
}

class BloqueMostrador {
  var property position
  
  method image() = "bloque_mostrador.png"
}

class BloqueInvisible {
  var property position
} // ------------------------------------------------------

const mostrador = new Mostrador(position = game.at(5, 2))
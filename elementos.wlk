import utiles.celdasOcupadas




class BloqueInvisible {
  var property position
} // ------------------------------------------------------



const entradatienda = new BloqueInvisible(position = game.at(8,6))


object mostradorU{
var property position = game.at(5,2)
method  image() = "mostrador.png"

  method initialize(){
  
  celdasOcupadas.ocupar(position)
  celdasOcupadas.ocupar(position.right(1))
  celdasOcupadas.ocupar(position.up(1))
  celdasOcupadas.ocupar(position.right(2))
  celdasOcupadas.ocupar(position.right(2).up(1))

  }

}
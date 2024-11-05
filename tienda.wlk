import empleado.*

class Tienda{
    var property image = "tienda.png"
    var property position = game.at(8,7)

    method nuevoEmpleado(posX, posY){
        const empleadoN = new Empleado(
        position = game.at(posX, posY),
        objetivo = game.at(posX, posY)
      )      
      game.addVisual(empleadoN)
  }
}

const tienda = new Tienda() //Armo en clase por si queremos actualizar la tienda
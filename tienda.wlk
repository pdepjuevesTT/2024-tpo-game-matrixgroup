import jugador.*
import escena.*
import constantes.*
import elementos.*
import computadora.*
import empleado.*

class Tienda {
  var property image = "tienda.png"
  var property position = game.at(8, 7)
  
  method llegoCliente() {
    if (jugador.enTienda()) {
      game.addVisual(dialogoGame)
      game.onTick(5000, "aparecer dialogo", { game.removeVisual(dialogoGame) })
    }
  }
  
  method venderEmpleados() {
    if (dinero.atributo() >= 100) {
      dinero.reducir(100)
      computadora.nuevaComputadora(0, 7)
    }
  }
}

const tienda = new Tienda() //Armo en clase por si queremos actualizar la tienda
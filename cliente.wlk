import constantes.*
import jugador.*
import elementos.*
import computadora.*
import npc.*
import escena.oficina

class Cliente inherits NPC (
  image = "jugador_frente.png",
  objetivo = celdaCompra,
  frente = "jugador_frente.png",
  atras = "jugador_atras.png",
  izquierda = "jugador_izquierda.png",
  derecha = "jugador_derecha.png"
) {
  var property barraProgreso = new BarraProgreso(
    position = celdaCompra.right(1),
    listaAssets = listaAssetsBarra
  )
  
  method irse() {
    objetivo = salidaCliente
    game.removeVisual(barraProgreso)
  }
  
  method compraExitosa() {
    self.irse()
    dinero.aumentar(100)
    producto.sacarProducto()
    producto.reiniciarPosicion()
  }
  
  method compraFallida() {
    if (barraProgreso.finalizo()) {
      self.irse()
      vida.reducir(1)
      vida.perder()
    }
  }
  
  method comprar() {
    if (!self.llego()) self.moverse()
    
    if (self.llego() && (objetivo == celdaCompra)) {
      barraProgreso.iniciar()
      if (producto.position() == cliente.position().up(1)) {
        self.compraExitosa()
        oficina.play("ventacliente.mp3")
      } else {
        self.compraFallida()
      }
    }
    
    
    if (self.llego() && (objetivo == salidaCliente)) game.schedule(
        6000,
        { 
          position = entradaCliente
          objetivo = celdaCompra
          barraProgreso.reiniciar()
        }
      )
  }
}

const cliente = new Cliente(
  image = "jugador_frente.png",
  objetivo = game.at(6, 1),
  frente = "jugador_frente.png",
  atras = "jugador_atras.png",
  izquierda = "jugador_izquierda.png",
  derecha = "jugador_derecha.png"
)
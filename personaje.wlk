object jugador {
  var property position = game.center()
  var property image = "jugador.png"

//Orientacion del jugador:
				var property orientacion = 0

        //Direcciones:
					var property arriba = 0
					var property abajo = 1
					var property izquierda = 2
					var property derecha = 3
    method giro(){
		
				if (orientacion == arriba){
					image = "jugador_back.png"
				}
				
				if (orientacion == abajo){
					image = "jugador.png"
				}
				
				if (orientacion == izquierda){
					image = "jugador_left.png"
				}
				
				if (orientacion == derecha){
					image = "jugador_right.png"
				}
			}

      
}


			
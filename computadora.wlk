import inicio.*
class Computadora {
var property positionXY
var property imageString
method image()= imageString
method position() = positionXY
}

const computadora3 = new Computadora(imageString = "computadora3.png",positionXY = game.at(5, 7))
const computadora2 = new Computadora(imageString = "computadora2.png", positionXY = game.at(5, 7))
const computadora = new Computadora(imageString = "computadora.gif", positionXY = game.at(5, 7))
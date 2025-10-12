import wollok.game.*
import direcciones.*

class Maiz {
	var property position 
	var property image = "corn_baby.png"
	var property estado = bebe

	method siembra(personaje){
		position = personaje.position()
		game.addVisual(self)
		cultivos.agregarCultivo(self)
	}

	method hayAlgunCultivoEnPosicionDe(personaje){
		return position == personaje.position()
	}

	method estaEnPosicion(posicion){
		return position == posicion
	}

	method cultivoAlRegar (){
		if(estado.esRegable()){
			image = "corn_adult.png"
			estado = adulta
		}
	}

	method esCosechadoPor(personaje){

		if(estado.esCosechable()){
			personaje.agregarACosechado(self)
			game.removeVisual(self)
			cultivos.removerCultivoEnPosicion(self)
		}
	}

	method precioDeVenta(){
		return 150
	}


}

object bebe {
	var property image = "corn_baby.png"

	method esCosechable (){
		return false
	}

	method esRegable(){
		return true
	}
}

object adulta {
	var property image = "corn_adult.png"

	method esCosechable (){
		return true
	}
	
	method esRegable(){
		return false
	}
}


class Trigo{
	var property position 
	var property etapa = 0

	method image(){
		return "wheat_" + etapa + ".png"
	}
	

	method siembra(personaje){
		position = personaje.position()
		game.addVisual(self)
		cultivos.agregarCultivo(self)
	}

	method estaEnPosicion(posicion){
		return position == posicion
	}

	method cultivoAlRegar(){
		if(etapa < 3){
			etapa = etapa +1
		} else {
			etapa = 0
		}
	}

	method esCosechadoPor(personaje){
		if(etapa >= 2){
			personaje.agregarACosechado(self)
			game.removeVisual(self)
			cultivos.removerCultivoEnPosicion(self)
		}
	}

	method precioDeVenta(){
			return (etapa - 1)*100
	}
}

class Tomaco{
	var property position
	var property image = "tomaco.png"

	method siembra(personaje){
		position = personaje.position()
		game.addVisual(self)
		cultivos.agregarCultivo(self)
	}

	method estaEnPosicion(posicion){
		return position == posicion
	}
	
	method cultivoAlRegar(){
		self.asertarRegado()
		if(not self.estaEnElLimiteSuperior()){
			position = game.at(position.x(),position.y()+1)
		} else {
			position = game.at(position.x(),0)
	}
}

	method asertarRegado(){
		if(cultivos.hayAlgunCultivoEnPosicion(game.at(position.x(),position.y()+1))){
			self.error ("No puede expandirse ya hay un cultivo en la celda superior")
		}
	}

	method estaEnElLimiteSuperior(){
		return position.y() == game.width ()- 1
	}

	method esCosechadoPor(personaje){
			personaje.agregarACosechado(self)
			game.removeVisual(self)
			cultivos.removerCultivoEnPosicion(self)
		}

	method precioDeVenta(){
		return 80
	}

}

object cultivos {
	const property cultivosPlantados = #{}

	method agregarCultivo (cultivo){
		cultivosPlantados.add(cultivo)
	}

	method hayAlgunCultivoEnPosicion(posicion){
		return cultivosPlantados.any({cultivo => cultivo.estaEnPosicion(posicion)})
	}

	method cultivoEnPosicionDe (granjero){
		return cultivosPlantados.find({cultivo => cultivo.estaEnPosicion(granjero.position())})
	}

	method removerCultivoEnPosicion(cultivo){
		cultivosPlantados.remove(cultivo)
	}

	method cantCultivosPlantadosEsIgualA(numero){
		return cultivosPlantados.size() == numero
	}

}
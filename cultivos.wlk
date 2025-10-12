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
	// PODRIA CAMBIAR IMAGEN SIN NECESIDAD DEL IF
	method cultivoAlRegar (){
		if(estado == bebe){
			image = "corn_adult.png"
			estado = adulta
		}
	}

	method esCosechadoPor(personaje){

		if(estado == adulta){
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

	//PREGUNTAR SI TRABAJAR LA IMAGEN ACA
}

object adulta {

}


class Trigo{
	var property position 
	var property image = "wheat_0.png"
	var property etapa = 0

	method siembra(personaje){
		position = personaje.position()
		game.addVisual(self)
		cultivos.agregarCultivo(self)
	}

	method estaEnPosicion(posicion){
		return position == posicion
	}

	// ESTO NO ME GUSTA PREGUNTAR SOBRE ETAPAS

	method cultivoAlRegar(){
		if(etapa == 0){
			image = "wheat_1.png"
			etapa = 1
		}else if(etapa == 1){
			image = "wheat_2.png"
			etapa = 2
		} else if(etapa == 2){
			image = "wheat_3.png"
			etapa = 3
		} else {
			image = "wheat_0.png"
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
		if(etapa == 2){
			return 200
		} else {
			return (etapa-1)* 100
		}
	}
}

class Tomaco{
	var property position
	var property image = "tomaco_baby.png"

	method siembra(personaje){
		position = personaje.position()
		game.addVisual(self)
		cultivos.agregarCultivo(self)
	}

	method estaEnPosicion(posicion){
		return position == posicion
	}
	
	method cultivoAlRegar(){
		if(not self.estaEnElLimiteSuperior()){
			position = game.at(position.x(),position.y()+1)
		} else {
			position = game.at(position.x(),0)
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

	method posicionDeCultivos(){
		return cultivosPlantados.map({cultivo => cultivo.position()})
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
}
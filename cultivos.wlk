import wollok.game.*

class Maiz {
	var property position 
	var property image = "corn_baby.png"

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

	method regado (){
		self.image("corn_adult.png")
	}
}


class Trigo{
	var property position 
	var property image = "wheat_0.png"

	method siembra(personaje){
		position = personaje.position()
		game.addVisual(self)
		cultivos.agregarCultivo(self)
	}

	method estaEnPosicion(posicion){
		return position == posicion
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
}

object cultivos {
	const property cultivosPlantados = #{}

	method agregarCultivo (cultivo){
		cultivosPlantados.add(cultivo)
	}

	//method posicionesSembradas(){
	//	return cultivosPlantados.map({cultivo => cultivo.position()})
	//}

	method hayAlgunCultivoEnPosicion(posicion){
		return cultivosPlantados.any({cultivo => cultivo.estaEnPosicion(posicion)})
	}
}
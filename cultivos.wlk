import wollok.game.*

class Maiz {
	var property position = game.at(1,1)
	var property image = "corn_baby.png"

	method siembra(personaje){
		position = personaje.position()
		personaje.position()
		game.addVisual(self)
	}

	method hayAlgunCultivoEnPosicionDe(personaje){
		return position == personaje.position()
	}
}

class Trigo{
	var property position 
	var property image = "wheat_0.png"

	method siembra(personaje){
		position = personaje.position()
		game.addVisual(self)
	}
}

class Tomaco{
	var property position 
	var property image = "tomaco_baby.png"

	method siembra(personaje){
		position = personaje.position()
		game.addVisual(self)
	}
}
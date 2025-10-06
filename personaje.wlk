import wollok.game.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"

	method siembraDe(cultivo){
		cultivo.siembra(self)
	}

	method regarCultivo(cultivo){
		if(self.asertarRiegoCultivo(cultivo)){
			
		}
	}

	method asertarRiegoCultivo(cultivo){
		return cultivo.hayAlgunCultivoEnPosicionDe(self)
	}
}
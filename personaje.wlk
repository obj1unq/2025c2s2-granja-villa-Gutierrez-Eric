import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "mplayer.png"

	// SIEMBRA CULTIVOS

	method siembraDe(cultivo){
		self.asertarSiembraCultivo() 
		cultivo.siembra(self)
	}

	method asertarSiembraCultivo(){
		if(cultivos.hayAlgunCultivoEnPosicion(self.position())){
			self.error ("Ya existe en cultivo en la posición")
		}
	}

	// RIEGO CULTIVOS

	method regarCultivo(cultivo){
		self.asertarRiegoCultivo()
		cultivo.regado()

	}

	method asertarRiegoCultivo(){
		if(not(cultivos.hayAlgunCultivoEnPosicion(self.position()))){
			self.error ("No tengo nada para regar")
		}
	}
}
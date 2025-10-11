import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "mplayer.png"
	const property cultivosCosechados = #{}
	var property dinero = 0

	method text() {
		return dinero.toString()
	}
	method textColor() {
		return "FF0000FF"
	}

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

	method riegoDeCultivo(){
		self.asertarRiegoCultivo()
		const cultivoARegar = cultivos.cultivoEnPosicionDe(self)
		cultivoARegar.cultivoAlRegar()

	}

	method asertarRiegoCultivo(){
		if(not(cultivos.hayAlgunCultivoEnPosicion(self.position()))){
			self.error ("No tengo nada para regar")
		}
	}

	// COSECHAR CULTIVOS

	method cosecharCultivo(){
		self.asertarCosecha()
		const cultivoACosechar = cultivos.cultivoEnPosicionDe(self)
		cultivoACosechar.esCosechadoPor(self)
	}

	method agregarACosechado(cultivo){
		cultivosCosechados.add(cultivo)
	}
	
	method asertarCosecha(){
		if(not(cultivos.hayAlgunCultivoEnPosicion(self.position()))){
			self.error ("No hay cultivo para cosechar")
		}
	}

	// VENTA CULTIVOS

	method ventaDeCultivosCosechados(){
		dinero = dinero + self.dineroDeCultivos().sum()
		cultivosCosechados.clear()
	}	

	method dineroDeCultivos(){
		return cultivosCosechados.map({cultivo => cultivo.precioDeVenta()})
	}

	//REVISAR(NO FUNCIONA)
	method bienesEnPosecion(){
		game.say(self,self.dineroYCultivos())
	}

	method dineroYCultivos(){
		return dinero.toString() + "monedas Y"+  cultivosCosechados.size().toString() + "cultivos"
	}

	
}

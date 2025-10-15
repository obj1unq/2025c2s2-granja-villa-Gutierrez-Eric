import wollok.game.*
import cultivos.*
import bonus.*

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


	// MOVIMIENTOS
	
	method mover(direccion){
        position = direccion.siguiente(position)
    }


	// SIEMBRA CULTIVOS

	method siembraDe(cultivo){
		self.asertarSiembraCultivo() 
		cultivo.siembra(self)
	}

	method asertarSiembraCultivo(){
		if(self.hayAlgoEnElLugarAPlantar()){
			self.error ("No puede sembrar en este lugar ya esta ocupado")
		}
	}

	method hayAlgoEnElLugarAPlantar(){
		return cultivos.hayAlgunCultivoEnPosicion(self.position())	||
				aspersores.hayAlgunAspersorEnPosicion(self.position()) ||
				mercados.hayAlgunMercadoEnPosicion(self.position())

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

	method cantCultivosCosechados(){
		return cultivosCosechados.size()
	}

	// VENTA CULTIVOS ANTES DEL BONUS

	// method ventaDeCultivosCosechados(){
	//	dinero = dinero + self.dineroDeCultivos().sum()
	//	cultivosCosechados.clear()
	// }

	// VENTA CULTIVOS DESPUES DEL BONUS 

		method ventaDeCultivosCosechados(){
			self.validarVenta()
			const mercado = mercados.mercadoEnPosicion(position)
		if (mercado.puedeComprarProductosDe(self)){
			mercado.comprarProductosDe(self)
			dinero = dinero + self.dineroDeCultivos().sum()
			cultivosCosechados.clear()
		}
	}

	method validarVenta(){
		if (!mercados.hayAlgunMercadoEnPosicion(position)){
			self.error("No hay existe un mercado aca")
		}
	}

	method dineroDeCultivos(){
		return cultivosCosechados.map({cultivo => cultivo.precioDeVenta()})
	}

	method bienesEnPosecion(){
		game.say(self,self.dineroYCultivos())
	}

	method dineroYCultivos(){
		return "Tengo " + dinero + " monedas Y " +  cultivosCosechados.size() + " cultivos"
	}

	// BONUS ASPERSORES

	method colocarAspersor(aspersor){
		self.asertarColocacionDeAspersor()
		aspersor.colocarEnPosicion(self.position())
	}

	method asertarColocacionDeAspersor(){
		if(mercados.hayAlgunMercadoEnPosicion(position) || cultivos.hayAlgunCultivoEnPosicion(position)){
			self.error("Hay algo en el lugar a colocar aspersor")
		}
	}
	//BONUS MERCADO

	method dineroDeCultivosQuePuedeVender(){
		return self.dineroDeCultivos().sum()
	}
}

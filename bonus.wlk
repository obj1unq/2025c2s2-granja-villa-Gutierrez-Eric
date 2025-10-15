import wollok.game.*
import cultivos.*

class Aspersor {
    var property position
    
    method image (){
        return "aspersor.png"
    }

    method colocarEnPosicion(posicion){
        game.addVisual(self)
        position=posicion
        aspersores.agregarAspersor(self)
    }

  method regarLimitrofes(){
    const posicionesARegar = #{
            //Posiciones ortogonales
          position.up(1),
          position.right(1),
          position.down(1),
          position.left(1),
            //Posiciones diagonales
          position.up(1).right(1),
          position.up(1).left(1),
          position.down(1).right(1),
          position.down(1).left(1)
        }
        
        posicionesARegar.forEach{posicion => if(cultivos.hayAlgunCultivoEnPosicion(posicion)){
                                                const cultivoARegar = cultivos.cultivoEnPosicion(posicion)
                                                cultivoARegar.cultivoAlRegar()
                                            }
                                }
        }
}
   
    object aspersores {
    const  property aspersoresTotales = #{}

    method activarAspersores() {
      aspersoresTotales.forEach({aspersor => aspersor.regarLimitrofes()})
    }

    method agregarAspersor(aspersor){
        aspersoresTotales.add(aspersor)
    }
}

class Mercado {
    var property position 
    const property mercaderia = #{}
    var property monedas 

    method text() {
		  return monedas.toString()
	}

	  method textColor() {
		  return "FF0000FF"
	  }
    
    method image(){
        return "market.png"
    }

    method puedeVender(personaje){
      return (position == personaje.position()) and (monedas >= personaje.dineroDeCultivosQuePuedeVender())
    }

    method venderMercaderiaDe(personaje){
      const pagoMercaderia =  personaje.dineroDeCultivosQuePuedeVender()
      
      mercaderia.union(personaje.cultivosCosechados())
      personaje.ventaDeCultivosCosechados()
      monedas = monedas - pagoMercaderia
      
    }
}
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

       method estaEnPosicion(posicion){
          return position == posicion
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

    method hayAlgunAspersorEnPosicion(posicion){
    return aspersoresTotales.any({aspersor => aspersor.estaEnPosicion(posicion)})
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

    method puedeComprarProductosDe(personaje){
      return (monedas >= personaje.dineroDeCultivosQuePuedeVender())
    }

    method comprarProductosDe(personaje){
      const pagoMercaderia =  personaje.dineroDeCultivosQuePuedeVender()

      mercaderia.union(personaje.cultivosCosechados())
      monedas = monedas - pagoMercaderia
      
    }

    method estaEnPosicion(posicion){
      return position == posicion
    }
}

object mercados {
  const property mercadosDisponibles = #{mercado1,mercado2,mercado3,mercado4}

  method hayAlgunMercadoEnPosicion(posicion){
    return mercadosDisponibles.any({mercado => mercado.estaEnPosicion(posicion)})
  }
  
  method mercadoEnPosicion(posicion){
    return mercadosDisponibles.find({mercado => mercado.estaEnPosicion(posicion)})
  }
}

  const mercado1 = (new Mercado(position=game.at(0,0),monedas = 200))
  const mercado2 = (new Mercado(position=game.at(0,9),monedas = 1000))
  const mercado3 = (new Mercado(position=game.at(9,0),monedas = 1500))
  const mercado4 = (new Mercado(position=game.at(9,9),monedas = 2000))

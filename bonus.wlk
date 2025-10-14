import wollok.game.*

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

    
  method regarLimitrofes() {
        const posicionesARegar = [
            //pos ortogonales
          position.up(1),
          position.right(1),
          position.down(1),
          position.left(1),
          // posiciones diagonales
          position.up(1).right(1),
          position.up(1).left(1),
          position.down(1).right(1),
          position.down(1).left(1)
        ]
        posicionesARegar.forEach({posicion =>
          game.getObjectsIn(posicion).forEach({objeto => objeto.esRegada()})
        })
    }

    method planta() {
    return false
  }

  method puedeRegarse() {
    return false
  }

}

    object aspersores {
    const  property aspersoresTotales = #{}

    method activarAspersores() {
      aspersoresTotales.forEach({asp => asp.regarLimitrofes()})
    }

    method agregarAspersor(aspersor){
        aspersoresTotales.add(aspersor)
    }
}

class Mercado {
    var property position 

    method image(){
        return "market.png"
    }

    
}
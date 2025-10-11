


object arriba{
    method siguiente(posicion){
        if (posicion.y() < 9){
            return posicion.up(1)
        } else {
            return posicion.y(1)
        }
    }
}
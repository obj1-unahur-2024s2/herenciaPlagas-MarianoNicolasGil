class Barrio {
  const elementos = []

  method elementosBuenos() = elementos.count({ elemento => elemento.esBuenoParaHumanos() })

  method elementosMalos() = elementos.count({ elemento => !elemento.esBuenoParaHumanos() })

  method esCopado() = self.elementosBuenos() > self.elementosMalos()
}

class Hogar {
  var property nivelMugre
  var property confort

  method ataquePlaga(plaga) {
    nivelMugre += plaga.nivelDanio()
  }

  method esBuenoParaHumanos() = nivelMugre <= (confort / 2)
}

class Huerta {
  var property capacidadProduccion

  method ataquePlaga(plaga) {
    capacidadProduccion -= plaga.nivelDanio() * 0.1
    if (plaga.transmiteEnfermedades()) {
      capacidadProduccion -= 10
    }
  }

  method esBuenoParaHumanos() = capacidadProduccion > nivelMinimo.nivel()
}

class Mascota {
  var property salud

  method ataquePlaga(plaga) {
    if (plaga.transmiteEnfermedades()) salud -= plaga.nivelDanio()
  }

  method esBuenoParaHumanos() = salud > 250
}

object nivelMinimo {
  var property nivel = 20
}






/////////// PLAGAS
class Plaga {
  var bichos
  
  method poblacion() = bichos

  method realizarAtaque(elemento) {
    elemento.ataquePlaga(self)
    self.efectoAtaque()
  }

  method efectoAtaque() { bichos = bichos * 1.1 }

  method transmiteEnfermedades() = self.poblacion() >= 10
}

class Cucaracha inherits Plaga {
  var pesoPromedio

  method nivelDanio() = self.poblacion() / 2

  override method efectoAtaque() {
    super()
    pesoPromedio += 2
  }

  override method transmiteEnfermedades() = super() and pesoPromedio >= 10
}

class Pulga inherits Plaga {
  method nivelDanio() = self.poblacion() * 2
}

class Garrapata inherits Pulga {
  override method efectoAtaque() { bichos = bichos * 1.2 }
}

class Mosquito inherits Plaga {
  method nivelDanio() = self.poblacion()

  override method transmiteEnfermedades() = super() and self.poblacion() % 3 == 0
}


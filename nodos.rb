# encoding: UTF-8

# Autor: Georvic Tur
# Carnet: 12-11402
# Email: alexanderstower@gmail.com

#   En este archivo se extienden las clases de Fixnum, String y Array.
#   También se definen las clases Mutador, Singular, Uniforme y Oscuro.

#   Extensión de Fixnum
class Fixnum
    
    #Encuentra el mutador indicado y lo ejecuta
    #mutador puede ser Singular, Uniforme u Oscuro.
    def mutar(mutador)
        mutador.operacion(self)
    end
    
    #Multiplica el primer dígito con la suma de los restantes
    def mutar_singular
    
        ultimo = self.modulo(10)
        iniciales = self.div(10)*10
        
        acum=0
        until iniciales <= 0 do
            acum += iniciales.modulo(10)
            iniciales = iniciales.div(10)*10
        end
        
        ultimo*acum
        
    end
    
    #Computa el promedio de los dígitos
    def mutar_uniforme
        
        numero = self.div(1)
        acum=0
        
        until numero <= 0 do
            acum += numero.modulo(10)
            numero = numero.div(10)*10
        end
        
        acum.to_f / self.length.to_f
        
    end
    
    #Nueva instancia del número sin las posiciones impares
    def mutar_oscuro
        
        i=0
        numero = self.div(1)
        nuevo = 0
        multiplicador=1
        until numero <= 0 do
            
            digito = numero.modulo(10)
            numero = numero.div(10)*10
            
            
            nuevo = nuevo*multiplicador + digito if i % 2 == 0
            multiplicador *= 10 if i % 2 == 0 
        end
        
        nuevo
    end
    
end

#    Extensión de Array
class Array
    
    
    #Encuentra el mutador indicado y lo ejecuta
    #mutador puede ser Singular, Uniforme u Oscuro.
    def mutar(mutador)
        mutador.operacion(self)
    end
    
    #Se interpolan los elementos en un String con espacios entre ellos
    def mutar_singular
        
        self.flatten
        self.join(" ")
    end
    
    #Se llama al método mutar de cada elemento del arreglo
    def mutar_uniforme
        
        self.collect do |elem| 
            elem.mutar_uniforme
        end
    end
    
    #Se llama al método mutar de una muestra aleatoria del 50% de los elementos
    def mutar_oscuro
        self.sample(self.length/2).collect do |elem|
            elem.mutar_oscuro
        end
    end
end


#    Extensión de String
class String
    
    
    #Encuentra el mutador indicado y lo ejecuta
    #mutador puede ser Singular, Uniforme u Oscuro.
    def mutar(mutador)
        mutador.operacion(self)
    end
    
    #Caracteres pertenecientes a singular son puestos en mayúscula
    def mutar_singular
        
        valor = ""
        nueva=""
        
        self.each_char do |letra|
            valor << letra.upcase if "singular".include?(letra)
            valor << letra if not "singular".include?(letra)
        end
        
        self.replace(valor)
        
    end
    
    #Quedan los caracteres en mayúscula y minúscula de manera intercalada
    def mutar_uniforme
        
        acum=""
        letra2=''
        i=0
        self.each_char do |letra|
            letra2 = letra.upcase if i % 2 == 0
            letra2 = letra.downcase if i % 2 == 1
            acum = acum + letra2
        end
        self.replace(acum)
        
    end
    
    #Los elementos en posiciones impares se agrupan y se concatenan por la 
    #izquierda con aquellos que estaban en posiciones pares
    def mutar_oscuro
        
        izq=""
        der=""
        
        i=0
        self.each_char do |letra|
            der << letra if i % 2 == 0 
            izq << letra if i % 2 == 1
        end
        
        valor = izq + der
        self.replace(valor)
        
    end
    
end

#    Padre de Singular, Uniforme y Oscuro
class Mutador
    def initialize
        raise "No se puede instanciar la clase abstracta Mutador"
    end
    
end


class Singular < Mutador
    def self.operacion(objeto)
        objeto.mutar_singular
    end
end


class Uniforme < Mutador
    def self.operacion(objeto)
        objeto.mutar_uniforme
    end
end


class Oscuro < Mutador
    def self.operacion(objeto)
        objeto.mutar_oscuro
    end
end

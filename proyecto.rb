
module BFS
    
    def recoger(&bloque)
        
        elementos_bfs = []
        
        bfs do |elemento|
            elementos_bfs << elemento
        end
        
        elementos_bfs.select(&bloque)
    end
    
    def bfs
        
        yield @auto
        
        nodos = []
        
        each do |hijo|
            nodos << hijo if hijo != nil
        end
        
        nodo = nil
        
        until nodos.empty? do
            
            nodo = nodos.shift
            
            nodo.each do |hijo|
                nodos << hijo if hijo != nil
            end
            
            yield nodo
        end
    end
end

module DFS
    
    def dfs
        
        yield @auto
        
        nodos = []
        
        each do |hijo|
            nodos << hijo if hijo != nil
        end
        
        nodo = nil
        
        until nodos.empty? do
            
            nodo = nodos.pop
            nodos_al_reves=[]
            
            nodo.each do |hijo|
                nodos_al_reves << hijo if hijo != nil
            end
            
            nodo = nodo + nodos_al_reves.reverse
            
            yield nodo
        end
    end
    
    
    def fold(valor_base, &bloque)
        
        elementos_dfs = []
        
        dfs do |elemento|
            elementos_dfs << elemento
        end
        
        elementos_bfs.inject(nil, &bloque)
    end
end

class NodoArbolBin
    
    include BFS
    
    
    def initialize(val,iz,de)
        @izq=iz
        @der=de
        @valor=val
        @auto = self
    end
    
    attr_accessor :valor, :izq, :der
    
    def each()
        yield izq
        yield der
    end
    
    def mutar(mutador)
        @valor = @valor.mutar(mutador)
    end
    
end


class NodoArbolRosa
        
    include BFS
    
    
    def initialize(val, hijs)
        @valor=val
        @hijos=hijs
        @auto = self
    end
    
    attr_accessor :valor, :hijos
    
    def each()
        hijos.each() do |v|
            yield v
        end
    end
    
    def mutar(mutador)
        @valor = @valor.mutar(mutador)
    end
    
end


class Fixnum
    
    def mutar(mutador)
        mutador.operacion(self)
    end
    
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
    
    def mutar_uniforme
        
        acum = 0
        self.each do |elem|
            acum += elem
        end
        
        acum.to_f / self.length.to_f
        
    end
    
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


class Array
    
    def mutar(mutador)
        mutador.operacion(self)
    end
    
    def mutar_singular
        
        self.flatten
        self.join(" ")
    end
    
    def mutar_uniforme
        
        self.collect do |elem| 
            elem.mutar_uniforme
        end
    end
    
    def mutar_oscuro
        self.sample(self.length/2)
    end
end

class String
    
    def mutar(mutador)
        mutador.operacion(self)
    end
    
    def mutar_singular
        
        valor = ""
        nueva=""
        
        self.each do |letra|
            valor << letra.upcase if "singular".include?(letra)
            valor << letra if not "singular".include?(letra)
        end
        
        self.replace(valor)
        
    end
    
    def mutar_uniforme
        
        self.swapcase
        
    end
    
    def mutar_oscuro
        
        izq=""
        der=""
        
        i=0
        self.each do |letra|
            der << letra if i % 2 == 0 
            izq << letra if i % 2 == 1
        end
        
        valor = izq + der
        self.replace(valor)
        
    end
    
end

class Mutador
    def initialize
        raise "No se puede instanciar la clase abstracta Mutador"
    end
    
end


class Singular < Mutador
    def operacion(objeto)
        objeto.mutar_singular
    end
end


class Uniforme < Mutador
    def operacion(objeto)
        objeto.mutar_uniforme
    end
end

class Oscuro < Mutador
    def operacion(objeto)
        objeto.mutar_oscuro
    end
end

# encoding: UTF-8
require "./nodos"
require "./mod_bfs"
require "./mod_fold"

# Autor: Georvic Tur
# Carnet: 12-11402
# Email: alexanderstower@gmail.com

#   En este archivo se definen las clases ArbolBinario y ArbolRosa
#   En ambos casos, los valores que sus nodos pueden almacenar son
#   de tipo Array, Fixnum y String.

class ArbolBinario
    
    def initialize(val=nil,iz=nil,de=nil)
        @izq=iz # Hijo Izquierdo
        @der=de # Hijo Derecho
        @valor=val # Valor del Nodo
        @auto = self # Se usa en los módulos para referenciar a la raíz
    end
    
    #Visibilidad
    attr_accessor :valor
    attr_reader :izq, :der
    
    #Itera sobre sus hijos
    def each()
        yield izq
        yield der
    end
    
    #Llama al método mutar del tipo de @valor
    def mutar(mutador)
        @valor = @valor.mutar(mutador)
    end
    
    #Módulos
    include BFS
    include DFS
    
end


class ArbolRosa
        
    include BFS
    include DFS
    
    def initialize(val=nil, *hijs)
        @valor=val #Valor del Nodo
        @hijos=hijs #Lista de Nodos
        @auto = self # Usado en los módulos para referenciar a la raíz
    end
    
    #Visibilidad
    attr_accessor :valor
    attr_reader :hijos
    
    #Itera sobre los hijos
    def each()
        hijos.each() do |v|
            yield v
        end
    end
    
    #LLama al método mutar del tipo de @valor
    def mutar(mutador)
        @valor = @valor.mutar(mutador)
    end
    
end





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
            
            yield @auto
        end
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
    
end




require "./nodos"
require "./mod_bfs"
require "./mod_fold"

# Autor: Georvic Tur
# Carnet: 12-11402
# Email: alexanderstower@gmail.com

class ArbolBinario
    
    
    def initialize(val=nil,iz=nil,de=nil)
        @izq=iz
        @der=de
        @valor=val
        @auto = self
    end
    
    attr_accessor :valor, :izq, :der, :auto
    
    
    def each()
        yield izq
        yield der
    end
    
    def mutar(mutador)
        @valor = @valor.mutar(mutador)
    end
    
    include BFS
    include DFS
    
end


class ArbolRosa
        
    include BFS
    include DFS
    
    def initialize(val=nil, *hijs)
        @valor=val
        @hijos=hijs
        @auto = self
    end
    
    attr_accessor :valor, :hijos, :auto
    
    def each()
        hijos.each() do |v|
            yield v
        end
    end
    
    def mutar(mutador)
        @valor = @valor.mutar(mutador)
    end
    
end




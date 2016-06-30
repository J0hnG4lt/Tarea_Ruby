
# Autor: Georvic Tur
# Carnet: 12-11402
# Email: alexanderstower@gmail.com

module BFS
    
    def recoger(s,&bloque)
        
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
            nodos << hijo if not hijo.nil?
        end
        
        nodo = nil
        
        until nodos.empty? do
            
            nodo = nodos.shift
            yield nodo
            nodo.each do |hijo|
                nodos << hijo if not hijo.nil?
            end
            
            
        end
    end
end

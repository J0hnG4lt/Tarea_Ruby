# encoding: UTF-8

# Autor: Georvic Tur
# Carnet: 12-11402
# Email: alexanderstower@gmail.com

#    En este archivo se implementa el módulo BFS

module BFS
    
    #Recorre con bfs el arbol y filtra los nodos según un predicado
    def recoger(bloque)
        
        elementos_bfs = []
        
        bfs do |elemento|
            elementos_bfs << elemento
        end
        
        seleccionados = elementos_bfs.select(&bloque)
        seleccionados.each do |elem|
            puts elem.valor
        end
    end
    
    #Reccore breadth first el árbol
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

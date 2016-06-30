# encoding: UTF-8

# Autor: Georvic Tur
# Carnet: 12-11402
# Email: alexanderstower@gmail.com

#   En este archivo se implementa el módulo DFS

module DFS
    
    # Recorre depth first el árbol
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
            
            nodos = nodos + nodos_al_reves.reverse
            
            yield nodo
        end
    end
    
    #Ejecuta un fold con un operador suministrado en el bloque
    def fold(valor_base, &bloque)
        
        elementos_dfs = []
        
        dfs do |elemento|
            elementos_dfs << elemento
        end
        
        elementos_dfs.inject(valor_base, &bloque)
    end
end

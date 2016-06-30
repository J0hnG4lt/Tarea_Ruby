    
    
    Autor: Georvic Tur
    Carnet: 12-11402
    Email: alexanderstower@gmail.com


    Observaciones

  Los bloques que reciben los folds han de tener el acumulador en 
  el primer argumento.
  
    Ejemplo: arbol_b_1.fold(0) { |acc,x| x.valor + acc}
  
  El archivo en donde se correrán pruebas con las estructuras hechas,
  sólo ha de importar las clases de la siquiente manera:
  
    require "./trees"
  
  Esto asume que dichos archivos estén en el mismo directorio.

defmodule Ejercicios do
  # Ejercicio 32: Escriba una funcion que tome una lista y elimine las repeticiones adyacentes de sus elementos.

  def eliminar_adyacentes(lista) do
    cond do
      lista == [] -> []
      
      # si a la list, le quitamos el primer elemento y es vacio, devolvemoss la lista
      tl(lista) == [] -> lista

      # si el primer elemento de la lista es igual al primer elemento de la lista (una vez aplicado el tl) llamamos a la funcion
      hd(lista) == hd(tl(lista)) -> eliminar_adyacentes(tl(lista))

      # se conserva el primero, y se integra en el resultado del resto de la lista
      true -> [hd(lista) | eliminar_adyacentes(tl(lista))]
    end
  end

  # Ejercicio 43: Escriba una funcion llamada 'intercalar-segun' que tome dos listas y una funcion como entrada,
  # y construya una nueva lista resultado de intercalar las dos primeras en el orden establecido por la funcion.
  # La funcion devuelve true si el primer elemento debe ir antes que el segundo.
  # Para obtener un resultado ordenado, ambas listas deben estar ordenadas con el mismo criterio.

  def intercalar_segun(lista1, lista2, funcion) do
    cond do
      
      # si la lista 1 es vacia, se devuelve la segunda lista
      lista1 == [] -> lista2

      # si la lista 2 es vacia, se devuelve la primera lista
      lista2 == [] -> lista1

      # si la funcion devuelve true, toma el primer elemento de la lista 1, y sigue aplicando la funcion a la lista restante
      funcion.(hd(lista1), hd(lista2)) -> [hd(lista1) | intercalar_segun(tl(lista1), lista2, funcion)]

      # Si la funcion devuelve false, toma el primer elemento de la lista 2, y sigue aplicacndo la funcion a la lista restante
      true -> [hd(lista2) | intercalar_segun(lista1, tl(lista2), funcion)]
    end
  end


  # Auxiliar: contar las apariciones de un simbolo en una lista.

  def contar_simbolo(lista, simbolo) do
    cond do

      # Si la lista es vacia, devuelve 0
      lista == [] -> 0

      # si el primer elemento de la lista es el simbolo, arrancando el contador
      hd(lista) == simbolo -> 1 + contar_simbolo(tl(lista), simbolo)

      # Si no coincide, devuelve el conteo del resto de la lista
      true -> contar_simbolo(tl(lista), simbolo)
    end
  end

  # Auxiliar: determinar si un numero natural, incluido el cero, es par.

  def es_par(numero) do
    cond do

      # si el nmumero es 0, devuelve true
      numero == 0 -> true

      # si el numero es 1, devuelve false
      numero == 1 -> false

      # Le resta 2 al numero
      true -> es_par(numero - 2)
    end
  end





  # Ejercicio 72: cadenas sobre {a, b} sin ningun posfijo con mas b que a.
  # Dominio: listas formadas solamente por :a y :b, incluida la lista vacia.
  # Cada llamada revisa el posfijo actual y luego pasa al siguiente con tl.


  def ejercicio72(lista) do
    cond do

      # Si la lista es vacia devuelve true
      lista == [] -> true

      # Si el posfijo tiene mas 'b' que 'a', devuelve false
      contar_simbolo(lista, :b) > contar_simbolo(lista, :a) -> false

      # En caso de que no posea mas 'b', sigue con la lista restante.
      true -> ejercicio72(tl(lista))
    end
  end




  # Ejercicio 73: cadenas sobre {a, b, c} con cantidad par de a, impar de b,
  # y cantidad de a mas cantidad de b igual a la cantidad de c.
  # Dominio: listas formadas solamente por :a, :b y :c, incluida la lista vacia.


  def ejercicio73(lista) do
    cond do

      # si la cantidad de simbolos de 'a' no es par, rechaza la cadena
      es_par(contar_simbolo(lista, :a)) == false -> false

      # si la cantidad de simbolos de 'b' no es impar, rechaza l a cadena
      es_par(contar_simbolo(lista, :b)) -> false

      # Devuelve el resultado de comparar la suma de simbolos de 'a' + 'b', con la cantidad de simbolos de 'c'
      true -> contar_simbolo(lista, :a) + contar_simbolo(lista, :b) == contar_simbolo(lista, :c)
    end
  end
end

IO.inspect(Ejercicios.eliminar_adyacentes([1, 1, 2, 2, 1, 3, 3]))
IO.inspect(Ejercicios.intercalar_segun([9, 6, 3], [8, 5, 2], fn a, b -> a > b end))

# Ejercicio 72: bbaa cumple; abba falla porque el posfijo bba tiene mas b que a.
IO.inspect(Ejercicios.ejercicio72([:b, :b, :a, :a]))
IO.inspect(Ejercicios.ejercicio72([:a, :b, :b, :a]))

# Ejercicio 73: aabccc cumple; abcc falla porque tiene una cantidad impar de a.
IO.inspect(Ejercicios.ejercicio73([:a, :a, :b, :c, :c, :c]))
IO.inspect(Ejercicios.ejercicio73([:a, :b, :c, :c]))

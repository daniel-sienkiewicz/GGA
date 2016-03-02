# Lab 2 zadanie 1 HP

# Generowanie danych poczatkowych
size =  Random.new_seed%1000
k = Random.new_seed%size
print "Rozmiar tablicy #{size}\nk = #{k}\n"
tab = (0...size).sort_by{rand}

# Wlasciwy algorytm plus czas
t1 = Time.now

# Podzial tablicy na mniejsze 5-elementowe

# Sortowanie mniejszych tablic

# Selekcja mediany

# Podzial wzgledem mediany

# Wybor wyniku

t2 = Time.now
delta = t2 - t1
print "Szukana liczba to #{value}\nAlgorytm wykonany w czasie #{delta.to_f}"
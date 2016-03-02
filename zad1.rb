# Zadanie 1

def partition(tab, p, r)
	x = tab[r]
	i = p - 1
	
	(p..r - 1).each do |j|
		if tab[j] <= x
			i++
			tmp = tab[i]
			tab[i] = tab[j]
			tab[j] = tmp
		end
	end
	tmp = tab[i + 1]
	tab[i + 1] = tab[r]
	tab[r] = tmp
	i + 1
end

def quicksort(tab, p, r)
	if p < r
		q = partition(tab, p, r)
		quicksort(tab, p, q - 1)
		quicksort(tab, q + 1, r)
	end
end

def pary(a, b)
	if a < b
		return [a, b]
	else
		return [b, a]
	end
end

# Sortowanie wbudowane w język Ruby
size =  Random.new_seed%1000
print "Rozmiar tablicy #{size}\n"

tab = Array.new()

(0..size).each do |i|
	tab[i] = Random.new_seed%size
end

t1 = Time.now
tab.sort
t2 = Time.now
delta = t2 - t1
print "Czas sortowaniw wbudowanego: #{delta.to_f}\n"

# Szukanie min i max przechodzac element po elemencie
max = tab[0]
min = tab[0]

t1 = Time.now
(0..tab.size - 1).each do |i|
	max = tab[i] if tab[i] > max
	min = tab[i] if tab[i] < min
end
t2 = Time.now
delta = t2 - t1
print "Czas: #{delta.to_f}\n"

# Quicksort
t1 = Time.now
quicksort(tab, 0, tab.size - 1)
t2 = Time.now
delta = t2 - t1
print "Czas quicksort: #{delta.to_f}\n"

# Porownywanie parami
max = tab[0]
min = tab[0]
t1 = Time.now
if tab.size%2 == 0
	(0..tab.size - 2).step(2) do |i|
		min =  pary(tab[i], tab[i + 1]).to_a[0] if min > pary(tab[i], tab[i + 1]).to_a[0]
		max = pary(tab[i], tab[i + 1]).to_a[1] if max <  pary(tab[i], tab[i + 1]).to_a[1]
	end
else
	(1..tab.size - 2).step(2) do |i|
		min =  pary(tab[i], tab[i + 1]).to_a[0] if min > pary(tab[i], tab[i + 1]).to_a[0]
		max = pary(tab[i], tab[i + 1]).to_a[1] if max <  pary(tab[i], tab[i + 1]).to_a[1]
	end
end
t2 = Time.now
delta = t2 - t1
print "Czas parami: #{delta.to_f}\n"
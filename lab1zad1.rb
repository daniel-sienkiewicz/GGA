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

print "+-----+----------------------+-----------------+--------------------+--------+ \n"
print "| n   | wbudowany            | MinMax          | QuickSort          | Parami |\n"
(100..10000).step(100) do |j|
	# Sortowanie wbudowane w język Ruby
	size =  j
	averageW = 0
	averageMM = 0
	averageQ = 0
	averageP = 0

	(0..50).each do |k|
		tab = Array.new()

		(0..size).each do |i|
			tab[i] = Random.new_seed%size
		end

		t1 = Time.now
		tab.sort
		t2 = Time.now
		delta = t2 - t1
		averageW += delta.to_f

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
		averageMM += delta.to_f

		# Quicksort
		t1 = Time.now
		quicksort(tab, 0, tab.size - 1)
		t2 = Time.now
		delta = t2 - t1
		averageQ += delta.to_f
		
		# Porownywanie parami
		max = tab[0]
		min = tab[0]
		t1 = Time.now
		if tab.size%2 == 0
			(0..tab.size - 3).step(2) do |i|
				value = pary(tab[i], tab[i + 1])
				min =  value.to_a[0] if min > value.to_a[0]
				max = value.to_a[1] if max <  value.to_a[1]
			end
		else
			(1..tab.size - 3).step(2) do |i|
				value = pary(tab[i], tab[i + 1])
				min =  pary(tab[i], tab[i + 1]).to_a[0] if min > value.to_a[0]
				max = value.to_a[1] if max <  value.to_a[1]
			end
		end
		t2 = Time.now
		delta = t2 - t1
		averageP += delta.to_f
	end
	averageW /= 50
	averageMM /= 50
	averageQ /= 50
	averageP /= 50
	print "| #{j} | #{j * Math.log2(j) *averageW} | #{averageMM} | #{j * Math.log2(j) * averageQ} | #{averageP} |\n"
end

print "+---+-----------+--------+-----------+--------+ \n"
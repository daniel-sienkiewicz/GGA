=begin
Zadanie APX.2
=end

# Klasa reprezentujaca punkt w ukladzie wspolrzednych
class Node
  attr_accessor :x, :y, :hospital

  def initialize(x,y)
    @x = x
    @y = y
    @hospital = false
  end

  def self.distance(p1, p2)
    return Math.sqrt((p2.x - p1.x)**2 + (p2.y - p1.y)**2)
  end
end

# Algorytm FurthestFirst(P; k)
def apx(list, k)
  # Lista wynikowa szpitali
  hospitals = []

  # Wybierz dowolny punkt s1 ∈ P jako lokalizację dla szpitala. S := {s1}.
  list[0].hospital = true
  hospitals << list[0]
  list.delete_at(0)

  # for j := 2 to k do
  (1...k).each do | i |
    dist = 0
    # Niech sj ∈ P będzie punktem najdalszym od s1, . . . , sj−1. S := S ∪ {sj}.
    for j in list
      for a in hospitals
        if Node.distance(j , a) > dist
          dist = Node.distance(j , a)
          tmp = j
        end
      end
      hospitals << tmp
      tmp.hospital = true
      list.delete(tmp)
    end
  end

  # return S
  return hospitals
end

# Operacje na pliku
file = File.new("data3", "r")
list = []
while (line = file.gets)
    p = Node.new(line.chomp.split(' ')[0].to_i, line.split(' ')[1].to_i)
    list << p
end
file.close

# Zebranie danych od uzytkownika
print "Podaj k: "
k = gets.chomp.to_i

result = apx(list, k)

# Wydruk wyniku w postaci tabelki
puts "Dane szpitali\n".center(40)
puts ("#" + "x".rjust(5) + "y".rjust(5)).center(40)
puts ("+" + "-"*3 + "+" + "-"*4 + "+" + "-"*4 + "+").center(40)
(0...result.length).each do | i |
  puts ("| #{ i + 1} |" + " #{result[i].x} |".rjust(5) + " #{result[i].y} |".rjust(5)).center(40)
end
puts ("+" + "-"*3 + "+" + "-"*4 + "+" + "-"*4 + "+").center(40)

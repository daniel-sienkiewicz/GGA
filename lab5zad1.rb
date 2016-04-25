=begin
Zadanie PD.1
=end

class Backpack
  attr_accessor :s
  attr_accessor :v

  def initialize(s, v)
    @s = s
    @v = v
  end

  # Algorytm pierwszy
  def self.w(obj, i, s)
    if i == 0
      if s < obj[i].s
        return 0
      else
        return obj[i].v
      end
    else
      if s < obj[i].s
        return Backpack.w(obj, i - 1, s)
      else
        return [Backpack.w(obj, i - 1, s), (Backpack.w(obj, i - 1, s - obj[i].s) + obj[i].v)].max
      end
    end
  end

  # Algorytm drugi
  def self.a(obj, i , v)
    if v == 0
      return 0
    elsif i == 0
      if obj[i].v == v
        return obj[i].s
      else
        return Float::INFINITY
      end
    else
      if v < obj[i].v
        return Backpack.a(obj, i - 1, v)
      else
        return [Backpack.a(obj, i - 1, v), (Backpack.a(obj, i - 1, v - obj[i].v) + obj[i].s)].min
      end
    end
  end
end

# Zebranie danych
print "Podaj wielkosc plecaka: "
s = gets.chomp.to_i

obj = []
wynikA = []

# Dane o rzeczach do plecaka
a1 = Backpack.new(6, 5)
a2 = Backpack.new(3, 1)
a3 = Backpack.new(4, 4)
a4 = Backpack.new(2, 2)

obj << a1
obj << a2
obj << a3
obj << a4

# Wydruk wczytanych danych
j = 1
puts "\nWczytane dane"
for i in obj
  puts "#{j} => #{i.s}, #{i.v}"
  j += 1
end

# Wynik algorytmu pierwszego
puts "\nRozwiazanie medota pierwsza W(#{obj.size}, #{s}) = #{Backpack.w(obj, obj.size - 1, s)}"
sum = 0
for i in obj do
  sum += i.v
end

(0..sum).each do | v |
  wynikA << Backpack.a(obj, obj.size - 1, v)
end

# Wynik algorytmu drugiego
puts "Rozwiazanie medota druga  A(#{obj.size}, #{wynikA.index(wynikA.inject{ | mem, i | i > mem && i <= s ? i : mem})}) = #{wynikA.inject{ | mem, i | i > mem && i <= s ? i : mem}}"

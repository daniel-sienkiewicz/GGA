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
        return 9999999
      end
    else
      if obj[i].v <= v
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
a1 = Backpack.new(6, 5)
a2 = Backpack.new(3, 1)
a3 = Backpack.new(4, 4)
a4 = Backpack.new(2, 2)

obj << a1
obj << a2
obj << a3
obj << a4

# Wynik algorytmu pierwszego
puts "Rozwiazanie medota pierwsza W(#{obj.size}, #{s}) = #{Backpack.w(obj, obj.size - 1, s)}"
sum = 0
for i in obj do
  sum += i.v
end

(0..sum).each do | v |
  wynikA << Backpack.a(obj, obj.size - 1, v)
end

# Wynik algorytmu drugiego
puts "Rozwiazanie medota druga  A(#{obj.size}, #{wynikA.index(wynikA.max)}) = #{wynikA.inject{ | mem, i | i > mem && i <= s ? i : mem}}"

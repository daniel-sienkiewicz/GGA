=begin
Zadanie PD.1
n = 100, 200 ,...1000
s(a) { 0 .. n}
v(a) = { 0 .. n}
S = { 0 .. n^2}

średnia z tych czas/ n^3 jako tabelka

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

delta1 = 0
delta2 = 0

puts "+-----+------------+------------+"
puts "|  n  | algorytm 1 | algorytm 2 |"
puts "+-----+------------+------------+"
(10..1000).step(10) do | n |
  print "| #{n} |"
  (0..n).each do
    # Zebranie danych
    s = Random.new_seed%n

    obj = []
    wynikA = []

    ile = Random.new_seed%n

    (0..ile).each do
      # Dane o rzeczach do plecaka
      i = Random.new_seed%n
      v = Random.new_seed%n
      obj << Backpack.new(i, v)
    end

    # Wynik algorytmu pierwszego
    t1 = Time.now
    Backpack.w(obj, obj.size - 1, s)
    t2 = Time.now
    delta1 += (t2 - t1).to_f
    delta1 /= n**3

    # Wynik algorytmu drugiego
    t1 = Time.now
    sum = 0
    for i in obj do
      sum += i.v
    end

    (0..sum).each do | v |
      wynikA << Backpack.a(obj, obj.size - 1, v)
    end
    t2 = Time.now

    delta2 += (t2 - t1).to_f
    delta2 /= n**3

  end
  puts " #{delta1} | #{delta2} |"

  delta1 = 0
  delta2 = 0
  puts "+-----+------------+------------+"
end

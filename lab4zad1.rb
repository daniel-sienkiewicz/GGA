=begin
Zadanie SWEEP.1
=end

def detect_maxima(s)
  # Posortuj s względem współrzędnej x, otrzymując punkty p1, p2, . . . , pn
  s.sort!{ | item1, item2 | item1.to_a[0] <=> item2.to_a[0]}

  d = []
  d << s[0]
  y_max = s[0][:y]
  y_min = s[0][:y]

  # Przesuwamy (wirtualną) miotłę z lewa na prawo
  (1..s.length - 1).each do | i |

    #Jeśli status prostej ulega zmianie, zgłaszane są odpowiednie punkty
    if s[i][:y] > y_max
      d << s[i]
      y_max = s[i][:y]
    end

    if s[i][:y] < y_min
      d << s[i]
      y_min = s[i][:y]
    end
  end

  d << s[s.length - 1]
  y_max = s[s.length - 1][:y]
  y_min = s[s.length - 1][:y]

  # W analogiczny sposób wszystkie punkty zostają przeglądnięte z prawa na lewo.
  (s.length - 2).downto(1) do | i |
     if s[i][:y] > y_max
        d << s[i]
        y_max = s[i][:y]
     end
     if s[i][:y] < y_min
       d << s[i]
       y_min = s[i][:y]
    end
  end

  d
end

s = []
# Operacje na pliku
file = File.new("data2", "r")

while (line = file.gets)
    p = Hash.new
    p[:x] = line.to_i
    line = file.gets
    p[:y] = line.to_i
    s << p
end
file.close

puts "Punkty:\n#{s.inspect}\n"

maxima = []
maxima = detect_maxima(s)

puts "Zbior maxymalny to:\n#{maxima.inspect}"

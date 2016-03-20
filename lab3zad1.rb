=begin
OBSZAR.1.R
=end

# Klasa opisujaca wierzcholek - z tych obiektow skladane zostaje cale drzewo
class Node
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def value
    @value
  end

  # Dodanie lewego syna
  def addLeft(l)
    @left = l
  end

  # Dodanie prawego syna
  def addRight(r)
    @right = r
  end

  def right
    @right
  end

  def left
    @left
  end

  # Dodanie elementu do drzewa
  def add(node)
    if node.value > @value
      if @right.nil?
        addRight(node)
      else
        @right.add(node)
      end
    else
      if @left.nil?
        addLeft(node)
      else
        @left.add(node)
      end
    end
  end

  # Przejscie drzewa inOrder
  def inOrder(node)
    if node.left != nil
      inOrder(node.left)
    end
    print "#{node.value}"
    if node.left.nil? && node.right.nil?
      print " => NIL\n"
    else
      print "\n"
    end

    if node.right != nil
      inOrder(node.right)
    end
  end

  # Przejscie drzewa postOrder
  def postOrder(node)
    if node.left != nil
      postOrder(node.left)
    end
    if node.right != nil
      postOrder(node.right)
    end
    p node.value
  end

  # Wyszukanie elementu vDziel
  def searchVdziel(node, x1, x2)
    if(node.value > x1 && node.value > x2)
      return node.searchVdziel(node.left, x1, x2)
    elsif (node.value < x1 && node.value < x2)
      return node.searchVdziel(node.right, x1, x2)
    end

    return node
  end

  # Wyszukanie x1 w drzewie
  def serachTreeX1(node, x, result)
    print "#{node.value} "
    if(node.value < x && !node.right.nil?)
      serachTreeX1(node.right, x, result)
    elsif(node.value > x && !node.left.nil?)
      serachTreeX1(node.left, x, result)
    end
  end

  # Wyszukanie x2 w drzewie
  def serachTreeX2(node, x, result)
    print "#{node.value} "
    if(node.value < x && !node.right.nil?)
      serachTreeX2(node.right, x, result)
    elsif(node.value > x && !node.left.nil?)
      serachTreeX2(node.left, x, result)
    end
  end

  private :addLeft
  private :addRight
end

# Wynik
result = []

# Operacje na pliku
file = File.new("data", "r")
line = file.gets
root = Node.new(line.to_i)
while (line = file.gets)
    root.add(Node.new(line.to_i))
end
file.close

# WYdruk drzewa inOrder
print "\nDrzewo inOrder:\n"
root.inOrder(root)

# Wczytanie danych od uzytkownika
puts "\nPodaj x1:"
x1 = gets.chomp.to_i
puts "Podaj x2:"
x2 = gets.chomp.to_i

# Wyszukiwanie wezla vDziel
vdziel = root.searchVdziel(root, x1, x2)
print "\nVdziel: #{vdziel.value}\n"

# Wyszukiwanie x1
vdziel.serachTreeX1(vdziel, x1, result)

# Wyszukiwanie x2
vdziel.serachTreeX2(vdziel, x2, result)

# Wydruk wyninku
print "Liczby ze zbioru [#{x1}, #{x2}]: "
print "#{result}\n"

def update_quality(items)
  items.each do |item|
    item.update
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

# Item = Struct.new(:name, :sell_in, :quality)
class Item
  attr_accessor :name, :sell_in, :quality
  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def self.build(name, sell_in, quality)
    case name
    when 'Aged Brie'
      AgedBrie.new(name, sell_in, quality)
    when 'Sulfuras, Hand of Ragnaros'
      Sulfuras.new(name, sell_in, quality)
    when 'Backstage passes to a TAFKAL80ETC concert'
      Backstage.new(name, sell_in, quality)
    when 'Conjured Mana Cake'
      Conjured.new(name, sell_in, quality)
    else
      self.new(name, sell_in, quality)
    end
  end

  def update
    self.sell_in -= 1
    return if quality < 1
    self.quality -= 1
    self.quality -= 1 if sell_in < 1
  end
end

class Conjured < Item
  def update
    self.sell_in -= 1
    self.quality -= 2
    self.quality -= 2 if sell_in < 0
    self.quality = 0 if quality < 0
  end
end

class Backstage < Item
  def update
    self.sell_in -= 1
    return self.quality = 0 if sell_in < 0
    self.quality += 1
    self.quality += 1 if sell_in < 10
    self.quality += 1 if sell_in < 5
    self.quality = 50 if quality > 50
  end
end

class AgedBrie < Item
  def update
    self.sell_in -= 1
    self.quality += 1
    self.quality += 1 if sell_in < 0
    self.quality = 50 if quality > 50
  end
end

class Sulfuras < Item
  def update
  end
end
# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]


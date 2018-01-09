class CartStorage
  include Enumerable

  def initialize
    @contanier = {}
  end

  def each
    @contanier.each do |item|
      yield item
    end
  end

  def items
    @contanier.values
  end

  def empty?
    @contanier.empty?
  end

  def delete key
    @contanier.delete key
  end

  def [] key
    @contanier[key]
  end

  def []= (key, value)
    @contanier[key] = value
  end

end

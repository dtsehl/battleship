class Ship
  attr_reader :name,
              :length

  def initialize(name,length)
    @name = name
    @length = length
  end

  def health
    
  end

  def sunk?
    if self.health <= 0
      true
    else
      false
    end
  end

  def hit


  end
end

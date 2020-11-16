class Hand

  def initialize(cards = [])
    if !cards.class.eql?Array
      @cards = []
    else
      @cards = cards
    end
  end

  def add_to_hand!(card)
    @cards.append(card)
  end

  def show_hand
    return @cards
  end

  def discard!(card)
    @cards.each_with_index {|cards, i| if cards == card; @cards.delete_at(i); break end}
  end
end

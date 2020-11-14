class Hand
  def intialize cards = []
    @cards = cards

  end

  def addToHand card
    @cards.add(@card)
  end

  def showHand
    return @cards
  end

  def discardCard card
    ## remove from array the element card.
  end


end
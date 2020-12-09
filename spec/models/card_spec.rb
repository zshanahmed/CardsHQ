require 'rails_helper'

RSpec.describe Card, type: :model do
  it 'Should return a special filename for Ace of Diamonds' do
    filename = Card.get_filename('Diamond','Ace')
    expect(filename).to eq 'AD1.png'
  end

  it 'Should return correct name schema given 2 strings' do
    filename = Card.get_filename('String1','String2')
    expect(filename).to eq 'SS.png'
  end
end

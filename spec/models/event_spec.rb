require 'rails_helper'

describe 'Event' do

  it 'debria tener 2 notas' do
    e = Event.new([])
    error = false
    begin
      e.fire
    rescue
    error=true
    end
    expect(error).to eq(true)
  end

end

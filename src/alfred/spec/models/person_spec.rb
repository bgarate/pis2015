require 'rails_helper'

describe Person do
  it "is valid with a name, email, celphone, phone, birth date and init date" do
    person = Person.new(
       name: 'Name',
       email: 'mail@domain.com',
       celphone: '090123456',
       phone: '22000000',
       birth_date: '01-01-1990',
       init_date: '01-01-2015' )
    expect(person).to be_valid
  end
end
require 'test_helper'

class PersonTest < ActiveSupport::TestCase

  def setup
    @person = Person.new(name: "Example Person", email: "people@example.com")
  end

  test "should be valid" do
    assert @person.valid?
  end
end
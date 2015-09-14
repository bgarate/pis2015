# == Schema Information
#
# Table name: people
#
#  id           :integer          not null, primary key
#  name         :string
#  email        :string
#  cellphone    :string
#  phone        :string
#  birth_date   :date
#  start_date   :date
#  end_date     :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  tech_role_id :integer
#  admin        :boolean
#

require 'test_helper'

class PersonTest < ActiveSupport::TestCase

  def setup
    @person = Person.new(name: "Example Person", email: "people@example.com")
  end

  test "should be valid" do
    assert @person.valid?
  end
end

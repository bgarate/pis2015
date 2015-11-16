require 'rails_helper'

describe 'Skill' do

  before do

    @s1= Skill.new :name => 'unskill'
    @s2= Skill.new :name => 'otroskill'
    @p1= Person.new :name => 'pepe', :email=> 'pepe@gmail.com', :start_date=> Time.now()
    @p1.skills<<@s1

  end

  it 'debe tener un skill' do
    expect(@p1.skills).to include(@s1)
  end

end
require 'rails_helper'

describe 'Tag' do

  before do
    @ms = Milestone.new :title => 'Destruir Death Star'
    @res = Resource.new :url => 'www.espadalaser.com'
    @ms.resources<<(@res)
    @cat = Category.new :name => 'Importante'
    @ms.category=@cat
    @ms.save!

    @tag = Tag.new :name => 'Ataque'
    @tag.milestones<<(@ms)

  end

  it 'debe tener hito ms' do
    expect(@tag.milestones).to include(@ms)
  end
end

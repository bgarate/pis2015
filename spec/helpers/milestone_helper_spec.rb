require 'rails_helper'
require 'spec_helper'

describe 'MilestoneHelper' do
  it 'Llamada a note_visibility_glyphicon' do
    n1=Note.create({:text=> 'una nota pa borrar', :visibility=> :me})
    expect(helper.note_visibility_glyphicon(n1)).not_to be_nil
  end
end
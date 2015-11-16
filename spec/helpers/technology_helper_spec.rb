require 'rails_helper'
require 'spec_helper'

describe 'TechnologyHelper' do
  it 'Llamada con id' do
    helper.technology_icon("lfblntfejcpmmkh0wfny.jpg")
    expect(response.status).not_to be_nil
  end

  it 'Llamada sin id' do
    helper.technology_icon(false)
    expect(response.status).not_to be_nil
  end
end
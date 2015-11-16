require 'rails_helper'
require 'spec_helper'

describe 'PersonHelper' do
  it 'Llamada con id' do
    helper.person_picture("lfblntfejcpmmkh0wfny.jpg")
    expect(response.status).not_to be_nil
  end

  it 'Llamada sin id' do
    helper.person_picture(false)
    expect(response.status).not_to be_nil
  end
end
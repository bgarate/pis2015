require 'rails_helper'

describe CategoriesController, "Categories Controller" do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }
  end

  describe 'Category' do

    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'creates a milestone' do
      post :new
      post :create, {:category=>{:name=>'otrofeedback', :icon=>'algun icono de feedback'}}
      expect(response.status).to eq(302)

    end

    it 'shows a category' do
      c1=Category.new
      c1.name='Otrofeedback'
      c1.icon='algunIcono'
      c1.save!

      get :show, :id=> c1.id
      expect(response).to redirect_to(categories_path)
    end


  end

end

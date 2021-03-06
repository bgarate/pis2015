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

    it 'creates a category' do
      post :new
      post :create, {:category=>{:name=>'otrofeedback', :icon=>'algun icono de feedback'}}
      expect(response.status).to eq(302)
    end

    it 'does not create a category' do
      c1=Category.new
      c1.name='otrofeedback'
      c1.icon='algunootroIcono'
      c1.save!
      post :new
      post :create, {:category=>{:name=>'otrofeedback', :icon=>'algun icono de feedback'}}
      expect(response).to redirect_to('/categories/new')
    end

    it 'shows a category' do
      c1=Category.new
      c1.name='Otrofeedback'
      c1.icon='algunIcono'
      c1.save!

      get :show, :id=> c1.id
      expect(response).to redirect_to(categories_path)
    end

    it 'updates a category' do
      c1=Category.new
      c1.name='otrofeedback'
      c1.icon='algunootroIcono'
      c1.save!
      get :edit, :id=> c1.id
      put :update, :id=>c1.id, :category=>{c1.icon=>'otroIcon'}
      expect(response.status).to eq(302)
    end

    it 'does not updates a category' do
      c1=Category.new
      c1.name='otrofeedback'
      c1.icon='algunootroIcono'
      c1.save!
      c2=Category.new
      c2.name='feed'
      c2.icon='algunootroIcono'
      c2.save!
      get :edit, :id=> c1.id
      put :update, :id=>c1.id, :category=>{c1.name=>'feed'}
      expect(response.status).to eq(302)
    end

    it 'destroys a category' do
      c1=Category.new
      c1.name='otrofeedback'
      c1.icon='algunootroIcono'
      c1.save!
      get :destroy, :category_id=>c1.id
      expect(response.status).to eq(302)
    end

    it 'desactive a category' do
      c1=Category.new
      c1.name='otrofeedback'
      c1.icon='algunootroIcono'
      c1.save!

      @m1 = Milestone.new :title=>'Entrega del prototipo de alfred', :description=>'Hay que entregar el protipo de alfred
                                  a la gente de pis. Ademas de cafe y galletitas maria gratis'
      @m1.due_date= Time.now - (3*2*7*24*60*60)
      @m1.category=c1
      @m1.status=0
      @m1.author = @admin
      @m1.save!
      get :destroy, :category_id=>c1.id
      expect(response.status).to eq(302)
    end

    it 'activate category' do
      request.env["HTTP_REFERER"] = root_path
      c1=Category.new
      c1.name='otrofeedback'
      c1.icon='algunootroIcono'
      c1.save!
      get :activate, :category_id=>c1.id
      expect(response.status).to eq(302)
    end

  end

end

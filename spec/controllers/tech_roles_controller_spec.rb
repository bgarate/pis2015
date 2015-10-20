require 'rails_helper'

describe TechRolesController, "tech Roles Controller" do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }
  end

  describe 'TechRole' do

    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'creates a tech_role' do
      post :new
      post :create, {:tech_role=>{:name=>'Nuevo Tech role'}}
      # expect(response.status).to eq(302)
      expect(flash[:notice]).to eq "Nuevo Tech role " + I18n.t('messages.create.success')
    end

    it 'does not create a tech role' do
      c1=TechRole.new
      c1.name='otrotechrole'
      c1.save!
      post :new
      post :create, {:tech_role=>{:name=>'otrotechrole'}}
      expect(flash[:alert]).to eq "otrotechrole " + I18n.t('messages.create.error')
    end

    #update
    it 'updates a tech role' do
      c1=TechRole.new
      c1.name='otrotechrole'
      c1.save!
      post :update, {:id=>c1.id, :tech_role=>{:name=>'otrotechroleupdateado'}}
      expect(flash[:notice]).to eq "otrotechroleupdateado " + I18n.t('messages.save.success')
    end

    #delete
    it 'deletes a tech role' do
      c1=TechRole.new
      c1.name='otrotechrole'
      c1.save!

      # delete :destroy, {:tech_role=>{:id=>c1.id}}
      delete :destroy, {:id=>c1.id}
      expect(flash[:notice]).to eq "otrotechrole " + I18n.t('messages.delete.success')
    end

  end

end

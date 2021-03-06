require 'rails_helper'

describe TechnologiesController, "Technologies Controller" do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }
  end

  describe 'Technology' do

    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'creates a technology' do
      p = double()
      allow(p).to receive(:valid?).and_return(true)
      allow(p).to receive(:identifier).and_return('unid')
      Cloudinary::PreloadedFile.stub(:new).with(anything()) { p }

      post :new
      post :create, {:technology=>{:name=>'Nueva Technologia', :icon=>'unicon'}}
      # expect(response.status).to eq(302)
      expect(flash[:notice]).to eq "Nueva Technologia " + I18n.t('messages.create.success')
    end

    it 'does not create a technology' do
      post :new
      post :create, {:technology=>{:name=>''}}
      expect(flash[:alert]).to eq " " + I18n.t('messages.create.error')
    end

    it 'redirects to index' do
      c1=Technology.new
      c1.name='tec'
      c1.save!
      get :show, :id=>c1.id
      expect(response.status).to redirect_to(technologies_path)
    end

    #update
    it 'updates a technology' do
      p = double()
      allow(p).to receive(:valid?).and_return(true)
      allow(p).to receive(:identifier).and_return('unid')
      Cloudinary::PreloadedFile.stub(:new).with(anything()) { p }

      c1=Technology.new
      c1.name='tec'
      c1.save!
      get :edit, :id=>c1.id
      post :update, {:id=>c1.id, :technology=>{:name=>'tec_updateado', :icon=>'unicon'}}
      expect(flash[:notice]).to eq "tec_updateado " + I18n.t('messages.save.success')
    end

    it 'does not update a technology' do
      c1=Technology.new
      c1.name='tec'
      c1.save!
      get :edit, :id=>c1.id
      post :update, {:id=>c1.id, :technology=>{:name=>''}}
      expect(flash[:alert]).to eq " " + I18n.t('messages.save.error')
    end

    #delete
    it 'deletes a technology' do
      c1=Technology.new
      c1.name='tec'
      c1.save!

      # delete :destroy, {:tech_role=>{:id=>c1.id}}
      delete :destroy, {:id=>c1.id}
      expect(flash[:notice]).to eq "tec " + I18n.t('messages.delete.success')
    end

    #delete
    it 'attach_icon' do
      t=Technology.new
      t.name='tec'
      t.save!

      p = double()
      allow(p).to receive(:valid?).and_return(true)
      allow(p).to receive(:identifier).and_return('unid')
      Cloudinary::PreloadedFile.stub(:new).with(anything()) { p }

      tc = TechnologiesController.new
      expect(tc.attach_icon(t,'icon')).not_to eq NIL
    end

  end

end
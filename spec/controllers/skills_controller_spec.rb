require 'rails_helper'

describe SkillsController, 'Skills Controller' do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }
  end

  describe 'Skills' do

    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'creates a skill' do
      post :new
      post :create, {:skill=>{:name=>'Nuevo skills', :icon=>'image/upload/v1447626971/jmtrct8ndgl78fzvwyuh.png#7ecc51673e6ae66c8b797b1e21d26d448352fa2b'}}
      expect(response.status).to eq(302)
    end

    it 'does not create a skill' do
      c1=Skill.new
      c1.name='unskill'
      c1.save!
      post :new
      post :create, {:skill=>{:name=>'unskill'}}
      expect(response.status).to eq(302)
    end

    it 'shows a skill' do
      c1=Skill.new
      c1.name='unskill'
      c1.save!
      get :show, :id=>c1.id
      expect(response.status).to eq(302)
    end

    #update
    it 'updates a skill' do
      c1=Skill.new
      c1.name='unskill'
      c1.save!
      get :edit, :id=>c1.id
      post :update, {:id=>c1.id, :skill=>{:name=>'otroskillupdateado',:icon=>'image/upload/v1447626971/jmtrct8ndgl78fzvwyuh.png#7ecc51673e6ae66c8b797b1e21d26d448352fa2b'}}
      expect(response.status).to eq(302)
    end

    #update
    it 'does not update a skill' do
      c1=Skill.new
      c1.name='unskill'
      c1.save!
      c2=Skill.new
      c2.name='otroskill'
      c2.save!
      post :update, {:id=>c2.id, :skill=>{:name=>'unskill'}}
      expect(response.status).to eq(200)
    end

    #delete
    it 'deletes a skill' do
      p1=Person.new
      p1.name= 'pepe'
      p1.email= 'pepe@gmail.com'
      p1.start_date=Time.now()
      p1.save!
      c1=Skill.new
      c1.name='unskill'
      c1.save!
      p1.skills<<c1
      p1.save!
      delete :destroy, {:id=>c1.id}
      expect(response.status).to eq(302)
    end

    it 'deletes a skill without person' do
      c1=Skill.new
      c1.name='unskill'
      c1.save!
      delete :destroy, {:id=>c1.id}
      expect(response.status).to eq(302)
    end

  end

end
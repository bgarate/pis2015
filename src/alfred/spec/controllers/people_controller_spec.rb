require 'rails_helper'

describe PeopleController do
  describe "GET new" do
    it "displays form" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET create" do
    it "should create with name and valid email" do
      @person = Person.new :name=>'NombreAdmin', :email=>'mail@admin.com', :admin=>true
      @person.save!
      get :create, {:person=>{:name=>'Nombre', :email=>'mail@example.com'},:session=>{:user_id=>@person.id}}
      expect(response.status).to eq(302)
    end
  end
end
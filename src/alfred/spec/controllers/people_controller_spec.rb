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
      get :create, {:person=>{:name=>'Nombre', :email=>'mail@example.com'}}
      expect(response.status).to eq(302)
    end
  end
end
require 'rails_helper'

describe GoogleController, "Login a traves de google oatuh" do

  it "Deveria guardar el id del usuario logueado en session y redirigir a home" do
    per = Person.new
    per.name = 'Alfred'
    per.email = 'alfred.pis.2015@gmail.com'
    per.save!

    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit '/auth/google_oauth2/callback'
    expect(current_path).to eq root_path

  end

  it "Deveria redirigir a unregistered" do

    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit '/auth/google_oauth2/callback'

    expect(current_path).to eq google_unregistered_path
  end

  it "Deveria poner el user id en session en nil y redirigir a home" do
    get :signout
    expect(session[:user_id]).to be_nil
    expect(response).to redirect_to(root_path)
  end

  it "Deveria renderizar unregistered con msj como parametro" do
    get :unregistered
    expect(assigns(:msj)).to eq('Usuario no regitrado, contacte a un administrador.')
    expect(response).to render_template('unregistered')
  end
end
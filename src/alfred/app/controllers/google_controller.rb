require 'pp'

class GoogleController < ApplicationController
=begin
  def test
    OmniAuth.config.test_mode = true
    omniauth_hash = { 'provider' => 'google',
                      'uid' => '12345',
                      'info' => {
                          'name' => 'natasha',
                          'email' => 'alfred.pis.2015@gmail.com',
                          'nickname' => 'NatashaTheRobot'
                      },
                      'extra' => {'raw_info' =>
                                      { 'location' => 'San Francisco',
                                        'gravatar_id' => '123456789'
                                      }
                      },
                      'credentials' => {'token' => 'UnTokenCualquiera',
                                        'expires_at' => Time.now
                      }
    }
    OmniAuth.config.add_mock(:google_oauth2, omniauth_hash)
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    redirect_to root_path
  end
=end

  def callback
    auth = env["omniauth.auth"]
    File.open("logCasero.txt", 'w') { |file| file.write(auth.nil?) }

    person = Person.find_by(email: auth.info.email)
    if person
      user =  User.find_by(person: person)
      if not user
        user = User.new
        user.person = person
      end
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!

      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to :controller => 'google', :action => 'unregistered'
    end
  end

  def signout
    session[:user_id] = nil
    redirect_to root_path
  end

  def unregistered
    @msj = String.new('Usuario no regitrado, contacte a un administrador.')
  end
end
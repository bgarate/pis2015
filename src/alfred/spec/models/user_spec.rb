require 'rails_helper'

describe User do
  usr = User.new
  expireated = Time.now - (2*7*24*60*60)
  not_expirated = Time.now + (2*7*24*60*60)

  describe '#saludar' do

      it 'No espirado' do
        usr.oauth_expires_at = not_expirated
        expect(usr.oauth_expired?).to eq(false)
      end

      it 'Expirado' do
        usr.oauth_expires_at = expireated
        expect(usr.oauth_expired?).to eq(true)
      end
  end
end

class User < ActiveRecord::Base
  belongs_to :person
  def oauth_expired?
    oauth_expires_at < Time.now
  end
end
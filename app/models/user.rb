# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  person_id        :integer
#  oauth_token      :string
#  oauth_expires_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ActiveRecord::Base
  belongs_to :person
  def oauth_expired?
    # oauth_expires_at < Time.now
    false
  end
end

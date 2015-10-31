# == Schema Information
#
# Table name: collection_templates
#
#  id            :integer          not null, primary key
#  collection_id :integer
#  template_id   :integer
#  days          :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CollectionTemplate < ActiveRecord::Base

  belongs_to :collection
  belongs_to :template
  
end

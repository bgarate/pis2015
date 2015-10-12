# == Schema Information
#
# Table name: milestones
#
#  id                 :integer          not null, primary key
#  title              :string
#  due_date           :date
#  description        :text
#  status             :integer          default(0)
#  icon               :string
#  feedback_author_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  category_id        :integer
#  start_date         :date
#

class Milestone < ActiveRecord::Base

  validates :title, :description, presence: true

  has_many :person_milestones
  has_many :people, through: :person_milestones
  has_many :notes
  has_many :resources
  has_and_belongs_to_many :tags
  belongs_to :category
  enum status: [:pending, :done, :rejected]

  # autor del feedback
  belongs_to :feedback_author, class_name: 'Person'

  def get_next_status
    status_order = [:pending, :done, :rejected]

    status_order[(status_order.find_index(self.status.to_sym) + 1) % status_order.count]

  end

  def get_visible_notes(current_person)
    self.notes.includes(:author).order(created_at: :desc).select {|n| filter_note_by_visibility(n,current_person)}
  end

  private
  def filter_note_by_visibility(note,current_person)
    (note.visibility=='every_body') ||
    (note.author_id==current_person.id) || #la hice yo?
    (note.visibility=='mentors' && Person.find(note.author_id).mentors.exists?(current_person.id)) || #si es para mentores, soy su mentor
    (current_person.admin?)
  end
end


class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user_id, :presence => true

  validates_uniqueness_of :user_id, :scope => :project_id

  validates :role, presence: true

  enum role: [:member, :owner]
end

class Task < ActiveRecord::Base
  belongs_to :project
  has_many :comments
  has_many :users, through: :comments

  validates :description, presence: true
end

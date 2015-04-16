class User < ActiveRecord::Base
  has_secure_password
  has_many :comments, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships
  has_many :tasks, through: :comments

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true


   def full_name
     "#{first_name} #{last_name}"
   end

   def owner?(project)
     self.memberships.where(role: 1).map(&:project).include?(project)
   end

   def member?(project)
     self.memberships.where(role: 0).map(&:project).include?(project)
   end

   def co_member?(user)
     memberships = self.projects.map(&:memberships).flatten
     memberships.amp(&:user).include?(user)
   end
end

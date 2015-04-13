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
end

class User < ActiveRecord::Base
  has_secure_password
  has_many :memberships
  has_many :projects, through: :memberships

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

   def full_name
     "#{first_name} #{last_name}"
   end
end

class Company < ApplicationRecord
  belongs_to :user
  has_one_attached :logo
  
  has_many :company_users, dependent: :destroy
  has_many :users, through: :company_users
  has_many :custom_templates, dependent: :destroy
  
  validates :name, presence: true
  
  def owner
    user
  end
  
  def add_user(user, role = "member")
    company_users.create!(user: user, role: role)
  end
  
  def remove_user(user)
    company_users.find_by(user: user)&.destroy
  end
  
  def has_user?(user)
    users.include?(user)
  end
end

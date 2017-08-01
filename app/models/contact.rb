class Contact < ApplicationRecord
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true

  belongs_to :user
  has_many :contact_groups
  has_many :groups, :through => :contact_groups

  def friendly_updated_at
    updated_at.strftime("%B %e, %Y")
  end

  def full_name
    "#{last_name}, #{first_name}"
  end

  def japan_phone_number
    "+81 #{phone}"
  end
end

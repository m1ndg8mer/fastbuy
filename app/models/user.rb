class User < ApplicationRecord
  rolify

  enum status: {active: 1, deleted: 0 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :assign_role

  validates :terms_and_conditions, acceptance: true
  has_many :reviews

  def assign_role
    self.add_role(:user) if self.roles.blank?
  end

  def soft_delete
    self.update_attribute(:status, 0)
  end

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    active? ? super : :deleted_account
  end

end

class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def name
    "#{first_name} #{last_name}"
  end

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :lockable,
         :timeoutable
         # :omniauthable
end

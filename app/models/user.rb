class User < ApplicationRecord
  before_destroy :last_admin_destroy
  before_update :last_admin_update

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  before_validation { email.downcase! }
  has_secure_password
  has_many :tasks, dependent: :destroy

  private
  def last_admin_destroy
    if User.where(admin: true).count == 1
      user = User.where(admin: true)
      if user[0] == self
        throw :abort
      end
    end
  end

  def last_admin_update
    if User.where(admin: true).count == 1 && self.admin == false
      user = User.where(admin: true)
      if user[0] == self
        errors.add(:user, '更新エラーです。現在あなたのみが管理人のため管理人から外れることはできません。')
        throw :abort
      end
    end
  end

end

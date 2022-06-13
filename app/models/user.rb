class User < ApplicationRecord
  
  has_many :tasks, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, length: { minimum: 6 }
  paginates_per 3  
  before_destroy :admin_exist_check
  before_update :admin_update_exist
    
  def admin_exist_check
      if User.where(role: true).count <= 1 && self.role == true
        throw(:abort)
      end
  end

  def admin_update_exist
    if User.where(role: true).count == 1 && self.role == false
      throw(:abort)
    end
  end

end

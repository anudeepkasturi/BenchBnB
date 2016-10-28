# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates_presence_of :username, :password_digest
  validates :username, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
    password = ""
  end

  def find_by_credentials(username, password)
    user = User.find_by_username(username)
    return user if (user && user.password?(password))
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end



  private
  def password? password
    bc_obj = BCrypt::Password.new(self.password_digest)

    if bc_obj == BCrypt::Password.create(password)
      true
    else
      false
    end
  end
end

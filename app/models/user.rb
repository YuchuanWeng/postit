class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false


  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 6}
  #using on: :create will help the update/edit pass the value instead of let user file it again
  sluggable_column :username


  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6))
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def send_pin_to_twilio
    account_sid = 'AC28ef05f3e673c0a582aa134d0915665a'
    auth_token = '37fadece235e357b72f16beb1b73994c'
    # set up a client to talk to the Twilio REST API
    client = Twilio::REST::Client.new account_sid, auth_token
    msg = "Your Pin code is #{self.pin}"
    client.account.messages.create({:from => '+441233800149', :to => '+4915171508826',:body => msg })
  end


  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator?'
  end

end

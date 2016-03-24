class User < ActiveRecord::Base
  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: { case_sensitive: false }, allow_nil: true, allow_blank: true
  # Devise Login Username or Email
  def self.find_for_database_authentication(warden_conditions)
       conditions = warden_conditions.dup
       if login = conditions.delete(:login)
         where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
       elsif conditions.has_key?(:username) || conditions.has_key?(:email)
         where(conditions.to_hash).first
       end
     end
end

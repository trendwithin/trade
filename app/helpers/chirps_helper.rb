module ChirpsHelper

  def to_name user
    user.username.nil? ? user.email : user.username
  end
end

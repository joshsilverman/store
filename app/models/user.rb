class User

  ATTRIBUTES = [:uid, :name, :nickname, :email, :first_name, :last_name]
  attr_accessor *ATTRIBUTES

  def initialize(attributes = {})
    self.attributes = attributes
  end

  def self.from_omniauth(omniauth)
    User.new(omniauth['info']).tap do | user |
      user.attributes = omniauth['extra']
      user.uid = omniauth['uid']
    end
  end

  def attributes
    ATTRIBUTES.inject(ActiveSupport::HashWithIndifferentAccess.new) do |result, key|
      result[key] = read_attribute_for_validation(key)
      result
    end
  end

  def attributes=(attrs)
    attrs.each_pair {|k, v| send("#{k}=", v) if respond_to?("#{k}=") }
  end

  def read_attribute_for_validation(key)
    send(key)
  end

end

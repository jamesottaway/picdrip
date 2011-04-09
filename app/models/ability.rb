class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    can :manage, Album, :user_id => user.id
    can :manage, Photo, :album => { :user_id => user.id }
  end
end

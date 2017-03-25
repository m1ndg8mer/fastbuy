class Ability
  include CanCan::Ability

  def initialize(user)
   user ||= User.new # guest user (not logged in)
   if user.has_role? :admin
     can :manage, :all
   else
     can :create, Review
     can :read, :all
   end
  end

end

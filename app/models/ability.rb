class Ability
  include CanCan::Ability

  def initialize(user)
   user ||= User.new # guest user (not logged in)
   if user.has_role? :admin
     can :manage, :all
   elsif user.has_role? :user
     can :create, [Review, Order]
     can :read, [Category, Product]
     can :read, Order, user_id: user.id
   else
     can :read, :all
     cannot :read, Order
   end
  end

end

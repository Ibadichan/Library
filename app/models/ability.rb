class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities; end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities

    can %i[read finish_sign_up], User, id: user.id
    can :search_others_users, User

    can :add_in_favorites, [Book] { |book| find_book_by(book.id).blank? }
    can :destroy, [Book] { |book| find_book_by(book.id) }

    can :create, Plan
    can %i[read destroy update], Plan, user_id: user.id
    can :share, Plan, user_id: user.id, public: false
    can :make_private, Plan, user_id: user.id, public: true

    can :subscribe, PlansBook do |plans_book|
      find_subscription_by(plans_book).blank? && !plans_book.marked?
    end

    can :unsubscribe, PlansBook do |plans_book|
      find_subscription_by(plans_book).present? && !plans_book.marked?
    end
  end

  private

  def find_book_by(id)
    user.books.find_by_id(id)
  end

  def find_subscription_by(plans_book)
    user.subscriptions.find_by(plans_book: plans_book)
  end
end

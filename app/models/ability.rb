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

  def guest_abilities
    # can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities

    can %i[read finish_sign_up], User, id: user.id

    can :add_in_favorites, [Book] { |book| find_book_by(book.id).blank? }
    can :destroy, [Book] { |book| find_book_by(book.id) }

    can :create, Plan
    can %i[read destroy update], Plan, user_id: user.id
  end

  private

  def find_book_by(id)
    user.books.find_by_id(id)
  end
end

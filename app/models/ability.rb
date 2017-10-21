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

    can :read, User, id: user.id
    can :finish_sign_up, User, id: user.id
    can :add_in_favorites, [Book] { |book| user_find_book(book).blank? }
    can :delete, [Book] { |book| user_find_book(book) }
  end

  private

  def user_find_book(book)
    user.books.find_by_id(book.id)
  end
end

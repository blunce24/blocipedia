class WikiPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all
      elsif user.role == 'premium'
        wikis = scope.where("private = :private or user_id = :user_id", { private: false, user_id: user.id })
      else
        wikis = scope.where("private = :private", { private: false })
      end
      wikis
    end
  end
end

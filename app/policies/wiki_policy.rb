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
        all_wikis = scope.all
        all_wikis.each do |wiki|
          collaborator = Collaborator.where("wiki_id = :wiki_id and user_id = :user_id", { wiki_id: wiki.id, user_id: user.id })
          if !wiki.private || wiki.user_id == user.id || collaborator
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        all_wikis.each do |wiki|
          collaborator = Collaborator.where("wiki_id = :wiki_id and user_id = :user_id", { wiki_id: wiki.id, user_id: user.id })
          if !wiki.private || collaborator
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end

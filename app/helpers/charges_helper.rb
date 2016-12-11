module ChargesHelper
  def downgrade_user
    current_user.role = 'standard'
    current_user.save!
    wikis = current_user.wikis
    wikis.each do |wiki|
      if wiki.private
        wiki.private = false
        wiki.save!
      end
    end
  end
end

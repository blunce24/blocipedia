class Wiki < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators
end

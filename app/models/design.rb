class Design < ApplicationRecord
  acts_as_votable
  belongs_to :user
  validates :title, presence: true, uniqueness: true, length: {maximum: 30, minimum: 4}
  validates :description, presence: true, length: {maximum: 120, minimum: 5}, uniqueness: true
  validates :image, presence: true
  validates :gender, presence: true
  validates :season, presence: true
  acts_as_commontable
end

class Design < ApplicationRecord
    acts_as_votable
    belongs_to :user
    validates :title, presence: true,
      uniqueness: true, length: {maximum: 30, minimum: 4}
    validates :description, presence: true,
     length: {maximum: 120, minimum: 5}, uniqueness: true
    validates :image, presence: true
    validates :gender, presence: true
    validates :season, presence: true
    has_attached_file :image, styles:
      { medium: "450x450>", thumb: "490x275>" }
    validates_attachment_file_name :image,
      matches: [/png\z/, /jpg\z/, /jpe?g\z/]
    validates_with AttachmentSizeValidator,
      attributes: :image, less_than: 1.megabytes
    acts_as_commontable
end

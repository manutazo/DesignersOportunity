class Design < ApplicationRecord
    is_impressionable
    acts_as_votable
    belongs_to :user
    validates :title, presence: true,
                      uniqueness: true, length: { maximum: 30, minimum: 4 }
    validates :description, presence: true,
                            length: { maximum: 120, minimum: 5 }, uniqueness: true
    validates :image, presence: true
    validates :gender, presence: true
    validates :season, presence: true
    has_attached_file :image, styles: {
        medium: '300x300>',
        thumb: {
            geometry: '100x100>',
            processor_options: {
                compression: {
                    png: false,
                    jpeg: '-copy none -optimize'
                }
            }
        }
    },
                              processors: [:thumbnail, :compression]
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
    acts_as_commontable
end

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
    has_attached_file :image, content_type: %w(image/jpeg image/jpg image/png image/gif),
                              message: 'is not gif, png, jpg, or jpeg.',
                              styles: {
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
    attr_accessor :base64_thumbnail_image
    acts_as_commontable

    def save_base64_thumbnail_image
        if base64_thumbnail_image.present?
            file_path = "tmp/foo_bar_thumbnail_image_#{id}.png"
            File.open(file_path, 'wb') { |f| f.write(Base64.decode64(base64_thumbnail_image)) }
            # set the paperclip attribute and let it do its thing
            self.thumbnail_image = File.new(file_path, 'r')
        end
      end

end

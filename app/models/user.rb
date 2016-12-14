class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    has_many :designs, dependent: :destroy
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
    validates :name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates_format_of :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?
    validates_confirmation_of :password
    validates :password, presence: true

    validates_length_of :password,
                        within: Devise.password_length, allow_blank: true

    validates_uniqueness_of :name,
                            case_sensitive: false, allow_blank: true, if: :name_changed?, length: { maximum: 11, minimum: 3 }
    validates :first_name, length: { maximum: 11, minimum: 3 }
    validates :last_name, length: { maximum: 11, minimum: 3 }
    validates :description, length: { maximum: 60 }
    # validate :image_present
    has_attached_file :avatar, content_type: %w(image/jpeg image/jpg image/png image/gif),
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
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
    attr_accessor :base64_thumbnail_image
    acts_as_commontator

    def save_base64_thumbnail_image
        if base64_thumbnail_image.present?
            file_path = "tmp/foo_bar_thumbnail_image_#{id}.png"
            File.open(file_path, 'wb') { |f| f.write(Base64.decode64(base64_thumbnail_image)) }
            # set the paperclip attribute and let it do its thing
            self.thumbnail_image = File.new(file_path, 'r')
        end
      end

      def image_present
        if avatar.present? && avatar_file_size < 2.megabytes
          errors.add(:file_size, "file size must be between 0 and 2 megabytes.")
        end
      end

end

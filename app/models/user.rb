class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
    validates :email, presence: true, uniqueness: true, on: :create
    validates_format_of :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?
    validates_confirmation_of :password
    validates :password, presence: true, on: :create

    validates_length_of :password,
                        within: Devise.password_length, allow_blank: true

    validates_uniqueness_of :name,
                            case_sensitive: false, allow_blank: true, if: :name_changed?, length: { maximum: 11, minimum: 3 }

    validates :birthday, presence: true, on: :create
    validates :first_name, on: :create, length: { maximum: 11, minimum: 3 }
    validates :last_name, on: :create, length: { maximum: 11, minimum: 3 }
    validates :description, on: :create, length: { maximum: 60 }
    validates_each :birthday do |record, attr, value|
        record.errors.add(attr, 'must be in the past') if value >= Time.now.to_date
    end

    validates_each :birthday do |record, attr, value|
        record.errors.add(attr, 'must be less than 150 years in the past')
        if value <= (Time.now.to_date - 125.years)
        end
    end

    has_many :designs, dependent: :destroy
    has_attached_file :avatar, styles: {
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
    acts_as_commontator
end

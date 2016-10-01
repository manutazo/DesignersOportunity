class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, :styles =>
         { :medium => "300x300>", :thumb => "100x100#" }
  validates_attachment_content_type :avatar, :content_type =>
         /\Aimage\/.*\Z/
  has_attached_file :image, styles:
        { medium: "450x450>", thumb: "490x275>" }
  validates_attachment_file_name :image, matches: [/png\z/, /jpg\z/, /jpe?g\z/]
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes
  acts_as_commontator
end

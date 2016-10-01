class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :trackable
  validates_uniqueness_of :email,
      :case_sensitive => false, :allow_blank => true, :if => :email_changed?
  validates_format_of :email,
      :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?
  validates_presence_of :password, :on=>:create
  validates_confirmation_of :password, :on=>:create
  validates_length_of :password,
      :within => Devise.password_length, :allow_blank => true
  validates_uniqueness_of :name,
      :case_sensitive => false, :allow_blank => true, :if => :name_changed?, length: {maximum: 11, minimum: 3}
  validates_presence_of :birthday, :on=>:create
  validates_presence_of :first_name,
      :on=>:create, length: {maximum: 11, minimum: 3}
  validates_presence_of :last_name,
      :on=>:create, length: {maximum: 11, minimum: 3}
  validates_presence_of :description,
      :on=>:create, length: {maximum: 60, minimum: 3}
  has_many :designs, dependent: :destroy
      has_attached_file :avatar, :styles =>
  { :medium => "300x300>", :thumb => "100x100#" }
      validates_attachment_content_type :avatar, :content_type =>
  /\Aimage\/.*\Z/
  acts_as_commontator

  def self.birth_date_first
    118.years.ago
  end

  def self.birth_date_last
    5.years.ago
  end

end

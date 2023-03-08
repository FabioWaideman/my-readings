class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, :password, presence: true
  validates :email, :username, uniqueness: true
end

class Transaction < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :transaction_categories
  has_many :categories, through: :transaction_categories
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :amount, presence: true, numericality: { greater_than: 0, only_integer: true}
end

class Category < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :transaction_categories
  has_many :transactions
  has_many :related_transactions, through: :transaction_categories, source: :related_transaction

  validates :name, presence: true
  validates :icon, presence: true

  def total_amount
    total = 0
    transactions.each do |transaction|
      total += transaction.amount.to_i
    end
    total
  end
end

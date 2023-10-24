class TransactionCategory < ApplicationRecord
  belongs_to :transaction
  belongs_to :category
end

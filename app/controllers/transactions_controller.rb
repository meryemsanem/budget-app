class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @category = Category.find(params[:category_id])
    @transactions = @category.transactions.where(author_id: current_user.id).order(created_at: :desc)
  end

  def new
    @category = Category.find(params[:category_id])
    @transaction = Transaction.new
  end

  def create
    @transaction = current_user.transactions.new(transaction_params)
    @transaction.user_id = current_user.id
    if @transaction.save
      redirect_to category_transactions_path(transaction_params[:category_id]),
                  notice: 'Transaction was successfully saved.'
    else
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name, :amount, :category_id)
  end
end

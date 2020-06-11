class BooksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def current_ability
    @current_ability ||= BookAbility.new(current_user)
  end

  def index
    render json: @books
  end

  def create
    @book = Book.new(book_params)
    @book.users << current_user
    @book.save!
    render json: @book.attributes
  rescue => error
    render json: { error: error }, status: 422
  end

  def show
    render json: @book.attributes
  end

  def update
    @book.update!(book_params)
    render json: @book.attributes
  rescue => error
    render json: { error: error }, status: 422
  end

  def destroy
    render json: @book.delete
  end

  def users
    render json: @book.users
  end

  private

  def book_params
    params.require(:book).permit(:title)
  end
end

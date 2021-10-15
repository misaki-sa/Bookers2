class UsersController < ApplicationController

  before_action :correct_user, only: [:edit, :update]

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
  end

  def index
    @book = Book.new
    @user = current_user
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
        render :edit
    else
        redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path
    else
      render :edit
    end
  end


  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path

  end

  private

  def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def correct_user
    @user = User.find(params[:id])

    redirect_to(user_path(current_user.id)) unless @user == current_user
  end

end

class UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id).where.not(gender: current_user.gender).order(id: "DESC")
  end

  def show
    @user = User.find(params[:id])
    @person = current_user.matchers
    @currentUserEntry=Entry.where(user_id: current_user.id)
      @userEntry=Entry.where(user_id: @user.id)
      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id then
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        if @isRoom
        else
          @room = Room.new
          @entry = Entry.new
        end
      end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def match_list
    @users = current_user.matchers
  end

  def follower_list
    @users = current_user.lovers
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :hometown, :email, :avatar, :comment)
  end
end

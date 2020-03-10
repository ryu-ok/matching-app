class MessagesController < ApplicationController
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
    if @message.save
      respond_to do |format|
        format.json
      end
    else
      flash.now[:alert] = 'メッセージを入力してください。'
      render :"/rooms/#{@message.room_id}"
    end
  end
end

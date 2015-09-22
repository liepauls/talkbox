class RoomsController < ApplicationController
  skip_before_action :clear_errors, only: [:new, :edit]

  def show
    authenticated?
    @messages = current_room.messages
  end

  def new
    @room = Room.new
  end

  def create
    room_params = { name:     params[:room][:name],
                    password: params[:room][:password],
                    user_id:  current_user.id }
    room = Room.new(room_params)

    if room.save
      session[:notification] = 'You have successfully created a new chatroom!'
      session[room.id] = true
      redirect_to room_path(room.id)
    else
      session[:err] = room.errors.full_messages.first
      redirect_to new_room_path
    end
  end

  def edit
    @room = current_room
  end

  def update
    @room = current_room

    if @room.update_with_password(room_params)
      session[:notification] = "You have successfully updated #{@room.name}!"
      redirect_to room_path(@room)
    else
      session[:err] = 'This name is not available.'
      render 'edit'
    end
  end

  def authenticate
    if params[:room_pwd] == current_room.password
      session[current_room.id] = true
      redirect_to room_path(params[:id])
    else
      render 'authenticate'
    end
  end

  def authenticated?
    if session[params[:id]] != true && current_room.password != ''
      redirect_to "/rooms/#{params[:id]}/authenticate"
    end
  end

  def destroy
    current_room.destroy
    redirect_to room_path
  end

  private

  def room_params
    params.require(:room).permit(:name, :password)
  end
end

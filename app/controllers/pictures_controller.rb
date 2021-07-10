class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy,]

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def create
    # @picture = Picture.new(picture_params)
    # @picture.user_id = current_user.id
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    elsif @picture.save
      ContactMailer.contact_mail(@contact).deliver
      redirect_to pictures_path, notice: 'Completed'
    else
      render :new
    end
  end

  def show
      @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    if logged_in?
      @favorite = current_user.favorites.find_by(user_id: @user_id)
    else
      record_to new_user_path, notice: 'Login!Camone!'
    end
  end

  def edit
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "Edited"
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path, notice: "Deleted post"
  end

  private
  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:title, :content, :image, :image_cache, :user_id)
  end

end

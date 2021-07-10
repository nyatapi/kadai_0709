class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

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
      redirect_to pictures_path, notice: 'Completed'
    else
      render :new
    end
  end

  def show
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
    params.require(:picture).permit(:title, :content, :image, :image_cache)
  end

end

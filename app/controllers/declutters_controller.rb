class DecluttersController < ApplicationController
  def new
    @declutter = Declutter.new
  end

  def create
    @declutter = Declutter.new(declutter_params)
    @declutter.user_id = current_user.id
    @declutter.save
    redirect_to declutters_path
  end

  def index
    @declutters = Declutter.all
  end

  def show
    @declutter = Declutter.find(params[:id])
  end

  def edit
    @declutter = Declutter.find(params[:id])
  end

  def destroy
    @declutter = Declutter.find(params[:id])
    @declutter.destroy
    redirect_to declutters_path
  end

  def update
    @declutter = Declutter.find(params[:id])
    @declutter.update(declutter_params)
    redirect_to declutter_path(@declutter.id)
  end

  private

  def declutter_params
    params.require(:declutter).permit(:thing_name, :thing_image, :caption)
  end

end

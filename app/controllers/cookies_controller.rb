class CookiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if @oven.cookie
      redirect_to @oven, alert: 'A cookie is already in the oven!'
    else
      @cookie = @oven.build_cookie
    end
  end

  def create
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    @cookie = @oven.create_cookie!(
      {
      "fillings" => cookie_params["fillings"], 
      "pickup_time" => Time.now + cookie_params["pickup_time"].to_i.minutes
      })

    redirect_to oven_path(@oven)
  end

  private

  def cookie_params
    params.require(:cookie).permit(:fillings, :pickup_time)
  end
end

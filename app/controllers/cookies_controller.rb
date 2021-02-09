class CookiesController < ApplicationController
  before_action :authenticate_user!
  @@batch_number = Cookie.last.batch_number + 1

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
  
    if @oven.cookies.length > 0
      redirect_to @oven, alert: 'A cookie is already in the oven!'
    else
      @cookie = @oven.cookies.build
    end
  end

  def create
    @oven = current_user.ovens.find_by!(id: params[:oven_id])

    params["batch_size"].to_i.times {
      Cookie.create(
        {
        "fillings" => cookie_params["fillings"], 
        "pickup_time" => Time.now + cookie_params["pickup_time"].to_i.minutes,
        "batch_number" => @@batch_number,
        "storage_id" => @oven.id,
        "storage_type" => "Oven",
        })
    }

    redirect_to oven_path(@oven)
  end

  private

  def cookie_params
    params.require(:cookie).permit(:fillings, :pickup_time, :batch_size)
  end
end

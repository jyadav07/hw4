class PlacesController < ApplicationController

  def index
    if User.find_by({ "id" => session["user_id"] }) == nil
      flash["notice"] = "You must be logged in."
      redirect_to "/login"
      return
    end

    @places = Place.all
  end

  def show
    if User.find_by({ "id" => session["user_id"] }) == nil
      flash["notice"] = "You must be logged in."
      redirect_to "/login"
      return
    end

    @place = Place.find_by({ "id" => params["id"] })

    @entries = Entry.where({
      "place_id" => @place["id"],
      "user_id" => session["user_id"]
    })
  end

  def new
    if User.find_by({ "id" => session["user_id"] }) == nil
      flash["notice"] = "You must be logged in."
      redirect_to "/login"
      return
    end
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place.save
    redirect_to "/places"
  end

end

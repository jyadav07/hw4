class EntriesController < ApplicationController

  def new
    # block if not logged in
    if User.find_by({ "id" => session["user_id"] }) == nil
      flash["notice"] = "You must be logged in."
      redirect_to "/login"
      return
    end

    # used to show the place name on the form
    @place = Place.find_by({ "id" => params["place_id"] })
  end

  def create
    # block if not logged in
    if User.find_by({ "id" => session["user_id"] }) == nil
      flash["notice"] = "You must be logged in."
      redirect_to "/login"
      return
    end

    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]
    @entry["user_id"] = session["user_id"]  # 👈 assign to current user
    @entry.save

    redirect_to "/places/#{@entry["place_id"]}"
  end

end


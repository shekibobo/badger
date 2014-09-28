class EventsController < ApplicationController
  def index
    @events = Event.all
    respond_to do |format|
      format.html
    end
  end

  def show
    @event = Event.find(params[:id])

    if params[:role_id]
      @role = Role.find(params[:role_id])
    else
      @role = Role.first
    end

    respond_to do |format|
      format.html
    end
  end

  def new
    @event = Event.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @event = Event.create(event_params)

    redirect_to @event
  end

  def import_image
    event = Event.find(params[:id])

    filename = Event.import_logo(params[:data], event.name)

    event.logo_path = filename
    event.save

    render nothing: true
  end

  private
    def event_params
      params.require(:event).permit(:name, :start_date, :end_date)
    end
end

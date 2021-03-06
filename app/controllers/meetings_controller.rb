class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /meetings or /meetings.json
  def index
    @currentTime = Time.zone.now
    @meetings = Meeting.all
    if user_signed_in?
      @meeting = current_user.meetings.build
    end
    
  end

  # GET /meetings/1 or /meetings/1.json
  def show
    @currentTime = Time.zone.now
  end

  # GET /meetings/new
  def new
    @meeting = current_user.meetings.build
    @datePass = params[:start_date]
    @timePass = params[:start_time]
    @meetings = Meeting.all
    @currentTime = Time.zone.now
  end

  # GET /meetings/1/edit
  def edit
    @currentTime = Time.zone.now
  end

  # POST /meetings or /meetings.json
  def create
    #@meeting = Meeting.new(meeting_params)
    @meeting = current_user.meetings.build(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to root_path, notice: "Meeting was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1 or /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: "Meeting was successfully updated." }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1 or /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: "Meeting was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def correct_user
    @meeting = current_user.meetings.find_by(id: params[:id])
    redirect_to meetings_path, notice: "Not Authorized To Edit This Meeting" if @meeting.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:start_date, :start_time, :description, :user_id)
    end
end

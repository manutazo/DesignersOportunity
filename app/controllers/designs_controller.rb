class DesignsController < ApplicationController
  before_action :find_params, only: [:show, :edit]
  before_action :authenticate_user!, except: [:index, :designs]
  before_action :authenticate_propetary, only: [:edit, :update, :Destroy]

  def show
    @design = find_params
    @propetary = propetary
    commontator_thread_show(@design)
  end


  def new
    @design = current_user.designs.new
  end


  def filter_gender
  end

  def filter_season
    @gender = gender_params
  end

  def filter
    @gender = gender_params
    @season = season_params
    if @gender == "all" &&   @season == "all"
      @designs = Design.all
    elsif @gender == "all"
      @designs = Design.where(season: @season)
    elsif @season == "all"
        @designs = Design.where(gender: @gender)
      else
        @designs = Design.where(gender: @gender, season: @season)
      end
  end

  def create
    @design = current_user.designs.new(design_params)
    respond_to do |format|
    if @design.save
      format.html { redirect_to @design, notice: "great #{current_user.name}! Your design was created successfully." }
      format.json { render action: 'show', status: :created, location: @design }
    else
      format.html { render action: 'new' }
      format.json { render json: @design.errors, status: :unprocessable_entity }
    end
  end
  end

  def designs
  @designs = Design.page(params[:page]).per(9)
  respond_to do |format|
      format.html
      format.js

  end
  end


  def update
      @design = find_params
  if  @design.update(design_params)
      redirect_to @design
    else
      redirect_to '/'
    end
  end

  def destroy
    @design = find_params
    @design.destroy
    redirect_to '/designs'
  end

  def upvote
    @design = find_params
    @design.upvote_by current_user
    redirect_to "/designs"
  end

  def downvote
    @design = find_params
    @design.downvote_by current_user
    redirect_to "/designs"
  end


  def designer
    @user = User.find(params[:id])
    @designs = Design.where(user_id:  @user.id)
  end

  private

  def design_params
    params.require(:design).permit(:title, :description, :image, :user_id, :season, :gender)
  end

  def find_params
    @design = Design.find(params[:id])
  end

  def gender_params
    (params[:gender])
  end

  def season_params
    (params[:season])
  end

  def propetary
    @designers = User.where(id: @design.user_id)
  end

  def authenticate_propetary
    @design = find_params
    if @design.user_id != current_user.id
     redirect_to @design
     end
  end
end

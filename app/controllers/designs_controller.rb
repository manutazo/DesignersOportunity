class DesignsController < ApplicationController
    before_action :find_params, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
    before_action :propetary, only: [:show]
    before_action :authenticate_user!, except: [:index, :designs]
    before_action :authenticate_propetary, only: [:edit, :update, :Destroy]

    def show
        commontator_thread_show(@design)
    end

    def filter_gender
    end

    def filter_season
        @gender = gender_params
    end

    def filter
        @gender = gender_params
        @season = season_params
        @designs = if @gender == 'all' && @season == 'all'
                       Design.all
                   elsif @gender == 'all'
                       Design.where(season: @season)
                   elsif @season == 'all'
                       Design.where(gender: @gender)
                   else
                       Design.where(gender: @gender, season: @season)
                     end
    end

    def create
        @design = current_user.designs.new(design_params)
        respond_to do |format|
            if @design.save
                format.html { redirect_to @design, notice: "great #{current_user.name}! Your design was created successfully." }
                format.json { render action: 'show', status: :created, location: @design }
            else
                format.html { redirect_to new_design_path, flash: { error: @design.errors.full_messages.join(', ') } }
                format.json { render json: @design.errors, status: :unprocessable_entity }
            end
        end
    end

    def show_all
        @designs = Design.page(params[:page]).per(9)
    end

    def update
        if  @design.update(design_params)
            redirect_to @design
        else
            redirect_to '/'
          end
    end

    def destroy
        @design.destroy
        redirect_to '/designs'
    end

    def upvote
        @design.upvote_by current_user
        redirect_to '/designs'
    end

    def downvote
        @design.downvote_by current_user
        redirect_to '/designs'
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
        params[:gender]
    end

    def season_params
        params[:season]
    end

    def propetary
        @propetary = User.where(id: @design.user_id)
    end

    def authenticate_propetary
        @design = find_params
        redirect_to @design if @design.user_id != current_user.id
    end
end

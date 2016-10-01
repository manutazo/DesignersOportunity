class DesignsController < ApplicationController

  def show
    @design = find_params
  end

  def new
    @design = current_user.designs.new
  end

  def create
      @design = current_user.designs.new(design_params)
      @design.save
  end

  def designs
      @designs = Design.order(:id)
  end

  def update
      @design = find_params
      @design.update
  end

  def destroy
    @design = find_params
    @design.destroy
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
  end

  private

  def design_params
    params.require(:design).permit(:title, :description, :image, :user_id, :season, :gender)
  end

end

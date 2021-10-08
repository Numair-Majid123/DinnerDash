# frozen_string_literal: true

module CategoryConcern
  extend ActiveSupport::Concern

  private

  def catergory_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  rescue StandardError => e
    flash[:alert] = e
    redirect_to :back
  end
end

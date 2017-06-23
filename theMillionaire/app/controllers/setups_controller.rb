class SetupsController < ApplicationController
  before_action :set_setup, only: [:show, :edit, :update, :destroy]
  #データベースから情報を見つけてくる


  # GET /setups/1
  # GET /setups/1.json
  def show
    @setups=session[:user_id]
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setup
      @setup = User.find_by(session[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setup_params
      params.fetch(:setup, {})
    end
end

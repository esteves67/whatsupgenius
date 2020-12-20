# frozen_string_literal: true

class HomeController < ApplicationController
  def index
  end

  def check_user
    user = User.find_by(user_token: params[:user_token])

    if user
      render json: { status: 'matched' }
    else
      render json: { status: 'unmatched' }
    end
  end
end

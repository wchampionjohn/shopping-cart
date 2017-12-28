class Admin::FunctionsController < ApplicationController
  def index
    @functions = CartFunction.all
  end
  def edit
    @function = CartFunction.find params[:id]
    @detail = @function.detail
  end
end

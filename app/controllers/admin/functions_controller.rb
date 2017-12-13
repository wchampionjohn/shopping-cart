class Admin::FunctionsController < ApplicationController
  def index
    @functions = CartFunction.all
  end
end

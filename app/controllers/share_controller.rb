class ShareController < ApplicationController

  before_action :authenticate_user!, :only => [:index, :new, :create, :edit,:update,:destroy]
  before_action :set_recipe, only: [:edit, :update, :destroy]
  
  respond_to :html

  
end

class RootController < ApplicationController
  layout false

  def index

    @userinfo = current_user.userinfo
  end
end
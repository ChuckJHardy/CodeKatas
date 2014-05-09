class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  NoUserFoundForCurrentUser = Class.new(StandardError)
  def current_user
    User.first || raise(NoUserFoundForCurrentUser.new('Make sure to create one user before running your tests. Current user will pick the first one'))
  end
end

class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    # Dummy korisnik ili privremeni objekt
    User.new(name: "Test User")
  end
end

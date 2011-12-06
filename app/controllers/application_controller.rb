class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  protected

    def login_required
      if !current_user
        respond_to do |format|
          format.html  {
            redirect_to '/auth/identity'
          }
          format.json {
            render :json => { 'error' => 'Access Denied' }.to_json
          }
        end
      end
    end

    def current_user
      session[:user]
    end
end

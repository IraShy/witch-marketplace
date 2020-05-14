class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
     flash[:authorization_error] = "❌ Not authorized ❌"
     redirect_to products_path
   end 
end

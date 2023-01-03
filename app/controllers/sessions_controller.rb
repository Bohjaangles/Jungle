class SessionsController < ApplicationController
  def new
  end

  def create
    # Look up User in db by the email address submitted to the login form and
    # convert to lowercase to match email in db in case they had caps lock on:
    
    # user = User.find_by(email: params[:login][:email].downcase) < --delete when line 13 passes tests

    password = params[:login][:password]
    email = params[:login][:email]
    user = User.authenticate_with_credentials(email, password)

    if user 
      session[:user_id] = user.id.to_s
      redirect_to root_path, notice: 'Successfully logged in!'
    else
      # if email or password incorrect, re-render login page:
      flash.now.alert = "Incorrect email or password, try again."
      render :new
    end  

    # Verify user exists in db and run has_secure_password's .authenticate() 
    # method to see if the password submitted on the login form was correct: 
    ### this has been commented from here
    # if user && user.authenticate(params[:login][:password]) 
    #   # Save the user.id in that user's session cookie:
    #   session[:user_id] = user.id.to_s
    #   redirect_to root_path, notice: 'Successfully logged in!'
    # else
    #   # if email or password incorrect, re-render login page:
    #   flash.now.alert = "Incorrect email or password, try again."
    #   render :new
    # end
    ### to here
  end

  def destroy
    # delete the saved user_id key/value from the cookie:
    session.delete(:user_id)
    redirect_to login_path, notice: "Logged out!"
  end
end

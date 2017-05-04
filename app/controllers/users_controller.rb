class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/'
    end
    erb :'users/new_user'
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect '/signup'
    end
    @user = User.create(:username => params[:username], :password => params[:password])
    session[:id] = @user.id
    redirect '/'
  end
end

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
    @user = User.create(:username => params[:username].downcase, :password => params[:password])
    session[:id] = @user.id
    redirect '/'
  end

  get '/login' do
    if logged_in?
      @user = current_user
      redirect "/users/#{@user.slug}"
    end
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      redirect "/signup"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user
      erb :'users/library'
    else
      redirect '/'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    end
    redirect '/'
  end

end

class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/'
    end
    @user = User.new
    erb :'users/new_user'
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect '/'
    else
      erb :'users/new_user'
    end
    # if params[:username] == "" || params[:password] == ""
    #   redirect '/signup'
    # end
    # if User.find_by(:username => params[:username])
    #   redirect '/signup'
    # else
    #   @user = User.create(:username => params[:username].downcase, :password => params[:password])
    #   session[:id] = @user.id
    #   redirect '/'
    # end
  end

  get '/login' do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    end
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
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

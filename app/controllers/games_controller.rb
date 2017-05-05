require 'pry'
class GamesController < ApplicationController

  get '/games/new' do
      redirect_if_not_logged_in
      erb :'games/create_game'
  end

  post '/games/new' do
    binding.pry
    if params[:title] == "" || params[:notes] == "" || params[:rating] == ""
      redirect '/games/new'
    end
    @user = current_user
    @game = Game.create(:title => params[:title], :notes => params[:notes], :rating => params[:rating])
    @game.user = @user
    @game.save
    redirect "/users/#{@user.slug}"
  end

  get '/games/:id/edit' do
    redirect_if_not_logged_in

    @game = Game.find_by_id(params[:id])
    if @game && @game.user == current_user
      erb :'games/edit'
    else
      redirect '/'
    end

  end

  post '/games/:id/edit' do
    @game = Game.find_by_id(params[:id])
    @game.title = params[:title]
    @game.notes = params[:notes]
    @game.save
    redirect "/users/#{@game.user.slug}"
  end

  get '/games' do
    @games = Game.all
    erb :'games/all_games'
  end

  get '/games/:id' do
    @game = Game.find_by_id(params[:id])
    erb :'games/show'
  end

  delete '/games/:id/delete' do
    @game = Game.find(params[:id])
    if @game.user == current_user
      @game.destroy
      redirect "/users/#{@game.user.slug}"
    else
      redirect "/games/#{@game.id}"
    end
  end

end

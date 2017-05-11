require 'pry'
class GamesController < ApplicationController

  get '/games/new' do
      redirect_if_not_logged_in
      erb :'games/create_game'
  end

  post '/games' do
    #if params[:title] == "" || params[:notes] == "" || params[:rating] == nil
      #redirect '/games/new'
    #end
    @game = current_user.games.build(:title => params[:title], :notes => params[:notes], :rating => params[:rating])
    if @game.save
      redirect "/users/#{current_user.slug}"
    else
      redirect '/games/new'
    end
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

  put '/games/:id' do
    @game = Game.find_by_id(params[:id])
    #if params[:title] == "" || params[:notes] == "" || params[:rating] == nil
      #redirect "/games/#{@game.id}/edit"
    #end
    if @game && @game.user == current_user
      if @game.update(params)
        redirect "/users/#{current_user.slug}"
      else
        # game did not update
        redirect "/games/#{@game.id}/edit"
      end
    else
      # you are not the owner hands off
      redirect "/games"
    end
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
    if @game && @game.user == current_user
      @game.destroy
      redirect "/users/#{@game.user.slug}"
    else
      redirect "/games/#{@game.id}"
    end
  end

end

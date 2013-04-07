get '/' do
  signed_in?
  @decks = Deck.all
  erb :index
end

post '/login' do
  user = User.authenticate(params[:email].downcase, params[:password])
  if user
    session[:user_id] = @user.id
    redirect '/'
  else
    redirect '/'
  end
end

get '/logout' do
  session.destroy
  redirect '/'
end


post '/signup' do 
  user = User.create(params)
  session[:user_id] = user.id
  redirect '/'
end


get "/game" do
  signed_in?
  @decks = Deck.all

  erb :deck
end

get "/game/:deck_id" do
  signed_in?
  @round = @current_user.rounds.create(:deck_id => params[:deck_id])
  session[:round] = @round.id
  @round.deck = Deck.find(params[:deck_id])
  session[:cards] = @round.deck.cards.pluck(:id)
  @card = Card.find(session[:cards].shift)

  erb :game
end

post "/game/:deck_id/:card_id" do 
  signed_in?
  if session[:cards].length == 0
    redirect '/'
  end
  @round = Round.find_by_id(session[:round])
  @guess = params[:answer]
  @previous_card = Card.find(params[:card_id])

  is_correct = (@previous_card.definition.downcase == @guess.downcase) 
  
  if is_correct 
    @is_correct = "correct!"
  else
    @is_correct = "incorrect."
  end

  @previous_card.guesses << @round.guesses.create(correct: is_correct)

  @card = Card.find(session[:cards].shift)

  @deck = Deck.find(params[:deck_id])

  erb :game
end
get "/game/:deck_id" do
 current_user = User.find_by_email("ben@email.com")#find_by_token(session[:token])
 round = current_user.rounds << Round.create()
 deck = round.last.deck = Deck.find(params[:deck_id])
 cards = deck.cards
 card_ids = []

  cards.each do |card|
    card_ids << card.id 
  end

  session[:cards] = card_ids

  @card = Card.find(session[:cards].shift)
  puts @card.inspect
  erb :game
end

post "/game/guess/:card_id" do 
  guess = params[:answer]
  card = Card.find(params[:card_id])

  is_correct = (card.definition == guess) 

  card.guesses << Guess.create(correct: is_correct)

  @card = Card.find(session[:cards].shift)

  erb :game
end

def create_round_and_deck(user)

end
module WkankiHelper
  def set_api_key(api_key)
    Wanikani.api_key = api_key
  end

  def wanikani_user
    return nil if Wanikani.api_key.blank?
    cache_object("wanikani/user/#{Wanikani.api_key}", expires: 300) do
      Wanikani::User.information
    end
  end

  def optional_argument(params)
    if params[:selected_levels] && params[:selected_levels] == "all"
      return nil
    else
      return params[:argument]
    end
  end

  def generate_anki_deck(cards)
    anki = Anki::Deck.new(card_data: cards)
    deck = "# Generated on #{Time.now.strftime('%B %d, %Y %H:%M %p %Z')}\n"
    deck += "# WaniKani to Anki Exporter (http://wanikanitoanki.com)\n"
    deck += anki.generate_deck
  end
end

Wkanki::App.helpers WkankiHelper
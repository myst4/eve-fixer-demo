module Sync
  # Publishes a listing to MercadoLibre through the meli_client gem.
  class MeliPublisher
    def initialize(listing)
      @listing = listing
    end

    def publish
      client.create_item(payload)
    end

    private

    attr_reader :listing

    def client
      MeliClient::Session.new(access_token: ENV.fetch("MELI_ACCESS_TOKEN"))
    end

    def payload
      {
        title: listing[:title],
        price: listing[:price_cents] / 100.0,
        currency_id: listing[:currency],
        available_quantity: listing[:stock],
      }
    end
  end
end

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def receive
    logger.info "Received webhook #{params.inspect}"
    transaction_id = params[:data][:id]
    account_id = params[:data][:account_id]
    account = Account.find_by_mondo_id(account_id)
    if account.present?
      mondo = Mondo::Client.new(
        token: account.access_token,
        account_id: account.mondo_id,
      )
      tx = mondo.transaction(transaction_id)
      logger.info "Fetched transaction #{tx.inspect}"
      if Merchant.find_by_mondo_id(tx.merchant.id).nil?
        # YAY, the customer is the first to visit this merchant!
        account.increment!(:points)
        mondo.create_feed_item(
          type: "image",
          title: "You discovered #{tx.merchant.name}!",
          image_url: "http://4sqatl.com/wp-content/uploads/2011/01/foursquare-badge-pa-groundhog-day-punxsutawney-phil.jpg",
          background_color: "#FCF1EE",
          body: "You have #{account.points} points! WOO!",
        )
      end
    else
      logger.error "Account #{account_id} is not in the database"
    end
    render text: "ok"
  end
end

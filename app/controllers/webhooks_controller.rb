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
        Merchant.create!(
          mondo_id: tx.merchant.id,
          mondo_data: tx.merchant.raw_data,
        )
        account.increment!(:points)
        mondo.create_feed_item(
          type: "image",
          title: "#{tx.merchant.name}!",
          image_url: "http://foursquareguru.com/media/badges/supermayor_big.png",
          background_color: "#DDFFDC",
          body: "You were here first! You have #{account.points} points! 🎉",
          app_uri: "mondo://basic_title_and_body",
        )
      end
    else
      logger.error "Account #{account_id} is not in the database"
    end
    render text: "ok"
  end
end

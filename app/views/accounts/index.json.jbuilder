json.array!(@accounts) do |account|
  json.extract! account, :id, :email, :access_token
  json.url account_url(account, format: :json)
end

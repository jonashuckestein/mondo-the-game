json.array!(@merchants) do |merchant|
  json.extract! merchant, :id, :email, :access_token
  json.url merchant_url(merchant, format: :json)
end

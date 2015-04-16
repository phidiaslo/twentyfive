json.array!(@cashouts) do |cashout|
  json.extract! cashout, :id, :amount, :user_id
  json.url cashout_url(cashout, format: :json)
end

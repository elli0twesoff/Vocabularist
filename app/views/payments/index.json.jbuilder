json.array!(@payments) do |payment|
  json.extract! payment, :id, :email, :stripe_id, :amount, :status
  json.url payment_url(payment, format: :json)
end

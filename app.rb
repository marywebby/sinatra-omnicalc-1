require "sinatra"
require "sinatra/reloader"

get("/") do
  erb(:homepage)
end

get ("/square/new") do 
  erb(:new_square_calc)
end

get ("/square/results") do 
  @the_num = params.fetch("users_number").to_f
  @the_result = @the_num ** 2
  erb(:square_results)
end

get ("/square_root/new") do 
  erb(:new_square_root)
end

get ("/square_root/results") do 
  @the_num = params.fetch("users_number").to_f
  @the_result = @the_num ** (0.5)
  erb(:square_root_results)
end

get ("/payment/new") do 
  erb(:new_payment)
end

require "active_support/all"

get ("/payment/results") do 
  apr = (params.fetch("apr").to_f)/ 100
  times_apr = apr * 100 
  @rounded_apr = times_apr.to_fs(:percentage, { :precision => 4} )
  @num_of_years = params.fetch("num_of_years").to_i 
  @num_of_months = @num_of_years * 12
  principal_params = params.fetch("principal").to_f
  @principal = principal_params
  @principal_currency = principal_params.to_fs(:currency, { :precision => 2 })


  monthly_interest_rate = apr / 12
  denominator = 1 - (1 + monthly_interest_rate) ** -@num_of_months

  monthly_payment = (monthly_interest_rate * @principal) / denominator

  @payment = monthly_payment.to_fs(:currency, { :precision => 2 })
  
  erb(:payment_results)
end

get ("/random/new") do 
  erb(:random)
end

get ("/random/results") do 
  @min = params.fetch("user_min").to_f
  @max = params.fetch("user_max").to_f
  random_float = rand(@min..@max)
  @random_num = random_float.round(15)
  erb(:random_results)
end

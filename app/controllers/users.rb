get '/login' do
  erb :'/users/login'
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/users/new' do
  erb :'/users/signup'
end

get '/users/:id' do
  cur_user = User.find_by(id: params[:id])
  user_surveys = cur_user.created_surveys
  return [500, "User does not exist"] unless cur_user
  erb :'/users/show', locals:{user: cur_user, surveys: user_surveys}
end

get '/users/:id/edit' do
  cur_user = User.find_by(id: params[:id])
  return [500, "User does not exist"] unless cur_user
  erb :'/users/edit', locals:{user: cur_user}
end

post '/users' do
  user_input = params[:user]
  new_user = User.new(user_input)
  return [500, "Invalid User"] unless new_user.save
  session[:user_id] = new_user.id
  redirect "/users/#{new_user.id}"
end

post '/login' do
  user_input = params[:user]
  cur_user = User.find_by(email: user_input[:email])
  return [500, "User does not exist"] unless cur_user
  if cur_user.authenticate(user_input[:password])
    session[:user_id] = cur_user.id
    redirect "/users/#{cur_user.id}"
  else
    redirect "/login"
  end
end

put '/users/:id' do
  cur_user = User.find_by(id: params[:id])
  return [500, "No User Found"] unless cur_user
  cur_user.update(params[:user])
  redirect "/users/#{cur_user.id}"
end

delete '/users/:id' do
  cur_user = User.find_by(id: params[:id])
  return [500, "No User Found"] unless cur_user
  cur_user.destroy
  redirect '/'
end


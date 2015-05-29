get '/surveys/:id/questions/:question_id/choices/new' do
  erb :'/choices/new'
end

post '/surveys/:id/questions/:question_id/choices/' do
  new_choice = Choice.new(params[:choice])
  return [500, 'Invalid Choice'] unless current_choice.save
  redirect '/surveys/:id/questions/:question_id/choices/#{new_choice.id}'
end

get '/surveys/:id/questions/:question_id/choices/choice_id' do
  current_choice = Choice.find_by(id: params[:id])
  erb :'/choices/show' locals: {choice: current_choice}
end

get '/surveys/:id/questions/:question_id/choices/choice_id/edit' do
  current_choice = Choice.find_by(id: params[:id])
  erb :'/choices/edit', locals: {choice: current_choice}
end

put '/surveys/:id/questions/:question_id/choices' do
  current_choice = Choice.find_by(id: params[:id])
  return [500, 'Invalid Choice'] unless current_choice
  current_choice.update(params[:choice])
  redirect '/surveys/:id/questions/:question_id/choices/:choice_id'
end

delete '/surveys/:id/questions/:question_id/choices' do
  current_choice = Choice.find_by(id: params[:id])
  current_choice.destroy
  redirect '/surveys/:id/questions/:question_id'
end

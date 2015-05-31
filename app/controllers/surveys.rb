get '/surveys' do
  all_surveys = Survey.all
  erb :'surveys/all', locals: {surveys: all_surveys}
end

get '/surveys/new' do
  require_logged_in
  erb :'surveys/new'
end

get '/surveys/:id/edit' do
  cur_survey = Survey.find_by(id: params[:id])
  return [500, 'sorry no matching survey could be found'] unless cur_survey
  if session[:user_id] == cur_survey.creator.id
    erb :'surveys/edit', locals: {survey: cur_survey}
  else
    redirect "/surveys/#{cur_survey.id}"
  end
end

get '/surveys/:id' do
  require_logged_in
  cur_survey = Survey.find_by(id: params[:id])
  return [500, 'sorry no matching survey was found'] unless cur_survey
  if cur_survey.creator_id == session[:user_id]
    erb :'surveys/_show-single-survey', locals: {survey: cur_survey}
  else
    erb :'/surveys/take', locals:{survey: cur_survey}
  end
end

get '/surveys/:id/results' do
  cur_survey = Survey.find_by(id: params[:id])
  questions = cur_survey.questions
  erb :'/surveys/results', locals: {survey: cur_survey, questions: questions}
end

post '/surveys/new' do
  new_survey = Survey.new(title: params[:survey][:title],
                          creator_id: current_user.id)
  return [500, 'sorry survey could not be created'] unless new_survey.save
  redirect "/surveys/#{new_survey.id}"
end

post '/surveys/:id/submit' do
  cur_survey = Survey.find_by(id: params[:id])
  user_input = params[:choice]
  current_user.surveys << cur_survey
  # binding.pry
  array_choices = []
  user_input.each{|key, value| array_choices << Choice.where(choice: value, question_id: key)}
  array_choices.flatten.each{|choice| current_user.choices << choice}
  redirect "/surveys/#{cur_survey.id}/results"
end

put '/surveys/:id' do
  cur_survey = Survey.find_by(id: params[:id])
  return [500, 'sorry no matching survey could be found'] unless cur_survey
  cur_survey.update(params[:survey])
  redirect "/surveys/#{cur_survey.id}"
end

delete '/surveys/:id' do
  cur_survey = Survey.find_by(id: params[:id])
  return [500, 'sorry no matching survey could be found'] unless cur_survey
  cur_survey.destroy
  redirect "/surveys/#{cur_survey.id}"
end

get '/surveys/all' do
  all_surveys = Survey.all
  erb :'surveys/all', locals: {surveys: all_surveys}
end

get '/surveys/:id' do
  cur_survey = Survey.find_by(id: params[:id])
  erb :'surveys/_single-survey', locals: {survey: cur_survey}
end

get '/surveys/new' do
  erb :'surveys/new'
end

post '/surveys/new' do
  new_survey = Survey.new(title: survey[:title],
                          creator_id: current_user.id)
  return [500, 'sorry survey could not be created'] unless new_survey.save
  redirect '/surveys/#{new_survey.id}'
end

get '/surveys/:id/edit'
  cur_survey = Survey.find_by(id: params[:id])
  return [500, 'sorry no matching survey could be found'] unless cur_survey
  erb :'surveys/edit', locals: {survey: cur_survey}
end

put '/surveys/:id'
cur_survey = Survey.find_by(id: params[:id])
  return [500, 'sorry no matching survey could be found'] unless cur_survey
  redirect '/surveys/#{cur_survey.id}'
end

delete '/surveys/:id'
  cur_survey = Survey.find_by(id: params[:id])
  return [500, 'sorry no matching survey could be found'] unless cur_survey
  redirect '/surveys/#{cur_survey.id}'
end

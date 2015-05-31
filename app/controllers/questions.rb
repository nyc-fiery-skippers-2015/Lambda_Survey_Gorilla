get '/surveys/:id/questions/new' do
  current_survey = Survey.find_by(id: params[:id])
  erb :'/questions/new', locals:{survey: current_survey}, layout: !request.xhr?
end

post '/surveys/:id/questions' do
  current_survey = Survey.find_by(id: params[:id])
  user_input = params[:question]
  new_question = Question.new(body: user_input[:body], survey_id: current_survey.id)
  return [500, "Invalid Question"] unless new_question.save
  current_survey.questions << new_question
  if request.xhr?
    return new_question.to_json
  end
  redirect "/surveys/#{current_survey.id}"
end

get '/surveys/:id/questions/:question_id' do
  current_survey = Survey.find_by(id: params[:id])
  current_question = Question.find_by(id: params[:question_id])
  current_choices = current_question.choices
  erb :'/questions/show', locals: {survey: current_survey, question: current_question, choices: current_choices}
end

get '/surveys/:id/questions/:question_id/edit' do
  current_survey = Survey.find_by(id: params[:id])
  current_question = Question.find_by(id: params[:question_id])
  erb :'/questions/edit', locals: {survey: current_survey, question: current_question}, layout: !request.xhr?
end

put '/surveys/:id/questions/:question_id' do
  current_survey = Survey.find_by(id: params[:id])
  current_question = Question.find_by(id: params[:question_id])
  return [500, 'Invalid Question'] unless current_question
  current_question.update(params[:question])
  if request.xhr?
    return current_question.to_json
  end
  redirect "/surveys/#{current_survey.id}/questions/#{current_question.id}"
end

delete '/surveys/:id/questions/:question_id' do
  current_survey = Survey.find_by(id: params[:id])
  current_question = Question.find_by(id: params[:question_id])
  current_question.destroy
  redirect "/surveys/#{current_survey.id}"
end

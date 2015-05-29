get '/surveys/:id/questions/new' do
  current_survey = Survey.find_by(id: params[:id])
  erb :'/questions/new', locals:{survey: current_survey}
end

post '/surveys/:id/questions' do
  current_survey = Survey.find_by(id: params[:id])
  user_input = params[:question]
  new_question = Question.new(body: user_input[:body], survey_id: current_survey.id)
  return [500, "Invalid Question"] unless new_question.save
  current_survey.questions << new_question
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
  erb :'/questions/edit', locals: {survey: current_survey, question: current_question}
end

put '/surveys/:id/questions' do
  user_input = params[:question]
  current_survey = Survey.find_by(id: params[:id])
  current_question = Question.find_by(body: user_input[:body])
  return [500, 'Invalid Question'] unless current_question
  current_question.update(user_input)
  redirect "/surveys/#{current_survey.id}/questions/#{current_question.id}"
end

delete '/surveys/:id/questions' do
  user_input = params[:question]
  current_survey = Survey.find_by(id: params[:id])
  current_question = Question.find_by(body: user_input[:body])
  current_question.destroy
  redirect "/surveys/#{current_survey.id}"
end

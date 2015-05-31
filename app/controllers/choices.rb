get '/surveys/:id/questions/:question_id/choices/new' do
  current_survey = Survey.find_by(id: params[:id])
  current_question = Question.find_by(id: params[:question_id])
  erb :'/choices/new', locals:{survey: current_survey, question: current_question}, layout: !request.xhr?
end

post '/surveys/:id/questions/:question_id/choices' do
  user_input = params[:choice]
  new_choice = Choice.new(choice: user_input[:choice], question_id: params[:question_id])
  return [500, 'Invalid Choice'] unless new_choice.save
  current_question = Question.find_by(id: params[:question_id])
  current_survey = Survey.find_by(id: params[:id])
  current_question.choices << new_choice
  if request.xhr?
    return new_choice.to_json
  end
  redirect "/surveys/#{current_survey.id}"
end

get '/surveys/:id/questions/:question_id/choices/:choice_id' do
  current_choice = Choice.find_by(id: params[:choice_id])
  current_survey = Survey.find_by(id: params[:id])
  current_question = Question.find_by(id: params[:question_id])
  erb :'/choices/show', locals: {choice: current_choice, survey: current_survey, question: current_question}
end

get '/surveys/:id/questions/:question_id/choices/:choice_id/edit' do
  current_choice = Choice.find_by(id: params[:choice_id])
  current_survey = Survey.find_by(id: params[:id])
  current_question = Question.find_by(id: params[:question_id])
  erb :'/choices/edit', locals: {choice: current_choice, survey: current_survey, question: current_question}
end

put '/surveys/:id/questions/:question_id/choices/:choice_id' do
  current_choice = Choice.find_by(id: params[:choice_id])
  current_survey = Survey.find_by(id: params[:id])
  current_question = Question.find_by(id: params[:question_id])
  return [500, 'Invalid Choice'] unless current_choice
  current_choice.update(params[:choice])
  redirect "/surveys/#{current_survey.id}/questions/#{current_question.id}/choices/#{current_choice.id}"
end

delete '/surveys/:id/questions/:question_id/choices/:choice_id' do
  current_choice = Choice.find_by(id: params[:choice_id])
  current_survey = Survey.find_by(id: params[:id])
  current_question = Question.find_by(id: params[:question_id])
  current_choice.destroy
  redirect "/surveys/#{current_survey.id}/questions/#{current_question.id}"
end

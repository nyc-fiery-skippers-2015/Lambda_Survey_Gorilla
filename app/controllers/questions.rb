get '/surveys/:id/questions/new' do
  survey = Survey.find_by(id: params[:id])
  erb :'/questions/new', locals:{survey: survey}, layout: !request.xhr?
end

post '/surveys/:id/questions' do
  survey = Survey.find_by(id: params[:id])
  # Better than setting survey_id in the Question object is to set it through the AR association
  # new_question = survey.questions.build(body: user_input[:body])
  user_input = params[:question]
  new_question = Question.new(body: user_input[:body], survey_id: survey.id)
  return [500, "Invalid Question"] unless new_question.save
  survey.questions << new_question
  if request.xhr?
    return new_question.to_json
  end
  redirect "/surveys/#{survey.id}"
end

get '/surveys/:id/questions/:question_id' do
  survey = Survey.find_by(id: params[:id])
  question = Question.find_by(id: params[:question_id])
  choices = question.choices
  erb :'/questions/show', locals: {survey: survey, question: question, choices: choices}
end

get '/surveys/:id/questions/:question_id/edit' do
  survey = Survey.find_by(id: params[:id])
  question = Question.find_by(id: params[:question_id]).includes(:survey)
  erb :'/questions/edit', locals: {survey: survey, question: question}, layout: !request.xhr?
end

# Having the survey_id in the route is superfluous.  We can infer it from the question.
# put '/questions/:question_id' do
put '/surveys/:id/questions/:question_id' do
  survey = Survey.find_by(id: params[:id])
  question = Question.find_by(id: params[:question_id])
  return [500, 'Invalid Question'] unless question
  question.update(params[:question]) # What if this fails?
  if request.xhr?
    return question.to_json
  end
  redirect "/surveys/#{survey.id}/questions/#{question.id}"
end

delete '/surveys/:id/questions/:question_id' do
  survey = Survey.find_by(id: params[:id])
  question = Question.find_by(id: params[:question_id])
  question.destroy
  redirect "/surveys/#{survey.id}"
end

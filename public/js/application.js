$(document).ready(function(){
  $('.add_question').on('click', getNewQuestion);
  $('.question').on('submit', '.new_question', addQuestion);
  $('.all_questions').on('click', '.add_choice', getNewChoice);
  $('.all_questions').on('submit', '.new_choice', addChoice);
});

var getNewQuestion = function(event){
  event.preventDefault();
  var $target = $(event.target);
  var surveyDiv = $target.closest('.single-survey')
  var surveyId = surveyDiv.attr('id')
  var controller_route = '/surveys/' + surveyId + '/questions/new'
  $.ajax({
    url: controller_route,
  }).done(function(response){
    surveyDiv.children('.question').append(response)
    surveyDiv.find('.add_question').toggle(false)
  }).fail(function(error){
    console.log(error);
  });
};

var addQuestion = function(event){
  event.preventDefault();
  var $target = $(event.target);
  var surveyDiv = $target.closest('.single-survey')
  var surveyId = surveyDiv.attr('id')
  $.ajax({
      method: 'post',
      url: $target.attr('action'),
      data: $target.serialize(),
      dataType: 'json'
  }).done(function(response){
    var link = '/surveys/' + surveyId + '/questions/' + response.id
    $('<div class="question-link"><a href="'+ link + '">'+ response.body + '</a></div>').appendTo($('.all_questions'));
    var link2 = '<div id="all_choices_' + response.id + '"><a class="add_choice btn-2 btn:hover" href="'+ '/surveys/' + surveyId + '/questions/' + response.id + '/choices/new' + '">'+ 'Add new Answer' + '</a></div>'
    $('.all_questions').append(link2)
    $('.new_question').toggle(false);
    $('.add_question').toggle(true);
  }).fail(function(error){
    console.log(error);
  });
};

var getNewChoice = function(event){
  event.preventDefault();
  var $target = $(event.target)
  var $parentDiv = $($target.parent())
  var controller_route = $target.attr('href')
  $.ajax({
    url: controller_route,
  }).done(function(response){
    $($parentDiv).append(response)
    $('.add_choice').toggle(false)
  }).fail(function(error){
    console.log(error);
  });
};

var addChoice = function(event){
  event.preventDefault();
  var $target = $(event.target);
  var parentDiv = $target.closest('.single_question')
  var questionId = parentDiv.attr('id')
  var link = parentDiv.attr('href')
  $.ajax({
      method: 'post',
      url: $target.attr('action'),
      data: $target.serialize(),
      dataType: 'json'
  }).done(function(response){
    var link = $target.attr('action') + '/' + response.id
    var divSelect = '#all_choices_' + response.question_id
    console.log(divSelect)
    $('<div class="single-choice"><a href="'+ link + '">'+ response.choice + '</a></div>').prependTo($(divSelect));
    $('.new_choice').toggle(false);
    $('.add_choice').toggle(true);
  }).fail(function(error){
    console.log(error);
  });
};

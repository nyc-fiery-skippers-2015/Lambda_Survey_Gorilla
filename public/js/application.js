$(document).ready(function(){
  $('.add_question').on('click', getNewQuestion);
  $('.question').on('submit', '.new_question', addQuestion);
  $('.add_choice').on('click', getNewChoice);
  $('.choice').on('submit', '.new_choice', addChoice);
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
    $('<a href="'+ link + '">'+ response.body + '</a>').appendTo($('.all_questions'));
    var link2 = '<div><a class="add_choice" href="'+ $target.attr('action') + '">'+ 'Add new Answer' + '</a></div>'
    $('.all_questions').append(link2)
    $('.new_question').toggle(false);
    $('.add_question').toggle(true);
  }).fail(function(error){
    console.log(error);
  });
};

var getNewChoice = function(event){
  event.preventDefault();
  var $target = $(event.target);
  var questionDiv = $target.closest('.single_question')
  var questionId = questionDiv.attr('id')
  var controller_route = $target.attr('href')
  $.ajax({
    url: controller_route,
  }).done(function(response){
    $('#' + questionId).append(response)
    $('.add_choice').toggle(false)
  }).fail(function(error){
    console.log(error);
  });
};

var addChoice = function(event){
  event.preventDefault();
  var $target = $(event.target);
  var questionDiv = $target.closest('.single_question')
  var questionId = questionDiv.attr('id')
  $.ajax({
      method: 'post',
      url: $target.attr('action'),
      data: $target.serialize(),
      dataType: 'json'
  }).done(function(response){
    var link = $target.attr('action') + '/' + response.id
    $('<div><a href="'+ link + '">'+ response.choice + '</a></div>').appendTo($('#' + questionId));
    $('.new_choice').toggle(false);
    $('.add_choice').toggle(true);
  }).fail(function(error){
    console.log(error);
  });
};

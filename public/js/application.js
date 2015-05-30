$(document).ready(function(){
  $('.add_question').on('click', getNewQuestion);
  $('.question').on('submit', '.new_question', addQuestion);
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
    $('.new_question').toggle(false);
    $('.add_question').toggle(true);
  }).fail(function(error){
    console.log(error);
  });

};
// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .

update_goals_completeness_percentage = function() {
  if (!$('#goal_completeness_percentage_view').is(':visible'))
    return
    
  $.get("timelines/progress", function(percentage){
    new_progress = percentage + '%'
    $('#progress_percentage').text(new_progress)
    $('.indicator').css('width', percentage)
  })
}


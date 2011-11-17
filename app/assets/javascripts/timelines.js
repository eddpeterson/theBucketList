$(function() {
  
  update_progress = function() {
    $.get("timelines/progress", function(percentage){
      new_progress = percentage + '%'
      $('#progress_percentage').text(new_progress)
      $('.indicator').css('width', percentage)
    })
  }
  update_progress()
  
  var $date_picker = $( '.due_date' ).datepicker({
    showOn: "button",
  	//buttonImage: "images/calendar.gif",
  	//buttonImageOnly: true,
  	buttonText: 'choose',
  	changeMonth: true,
  	changeYear: true,
  	onSelect: function(dateText, inst) {
  	  day = inst.currentDay
  	  month = inst.currentMonth + 1
  	  year = inst.currentYear
  	  goal = $(this).parent()
      id = goal.attr('id')
      $.post('timelines/set_due_date', {id: id, year: year, month: month, day: day}, function(data){ 
        //alert(data.past)
        goal.animate({ opacity: 0.25, left: '+=50', height: 'toggle'}, 500, function() {
            // debugger
            if (data.append_to_goal_id) $('#' + data.append_to_goal_id).append(goal)
            else {
              if (data.past == true) $('#past_box').prepend(goal)
              if (data.current == true) $('#current_box').prepend(goal)
              if (data.future == true) $('#future_box').prepend(goal) 
            }
            goal.animate({ opacity: 1, left: '+=50', height: 'toggle' }, 500)
        }) // closing all animations
      }) // closing $.post
	  }, // closing onSelect
  }) // closing datePicker
  
  //$('[id$="_status",value="done"]').addClass('todo_is_done')
  $('.status').filter('[value="done"]').addClass('todo_is_done')
  
  // $('[id$="_status"]').click(function() { 
  $('.status').click(function() { 
    
    id = $(this).parent().attr('id')
    current_status = $(this).attr('value')
    new_status = (current_status == 'done') ? 'undone' : 'done'
    $(this).attr('value', new_status)
    $.post("timelines/set_status", {id: id, status: new_status})       
    if (new_status == 'done') {
      $(this).addClass('todo_is_done')
    }
    else {
      $(this).removeClass('todo_is_done')      
    }
    
    
  })
   
})
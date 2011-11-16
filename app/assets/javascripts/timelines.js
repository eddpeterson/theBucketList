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
  	  $.post('timelines/set_due_date', {id: id, year: year, month: month, day: day})
  	  
  	  return
  	  goal.animate({
          opacity: 0.25,
          left: '+=50',
          height: 'toggle'
        }, 500, function() {
          // debugger
          //goal.show()
          //$('#past_box').append(goal)
          //$('#past_box').prepend(goal)
          // $.get('get_append_or_prepend_dude').{ appendTo: nil, prependTo: dude }. Call it before hide animation is fired. Right after post
          $('#4ec3c788667ee713dc000001').append(goal)
          goal.animate({
              opacity: 1,
              left: '+=50',
              height: 'toggle'
            }, 500)
          // Animation complete.
        })
  	},
  })
  
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
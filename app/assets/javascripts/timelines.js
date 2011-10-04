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
  	  id = $(this).parent().attr('id')
  	  $.post('timelines/set_due_date', {id: id, year: year, month: month, day: day})
  	},
  });
  
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
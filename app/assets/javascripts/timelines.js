$(function() {
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
$(function() {
        
  $( "#none, #personal, #family, #friends, #work, #social" ).sortable({
  	connectWith: ".frame",
  	opacity: 0.45,
  	update: function(event, ui) { 
  	  var frame = event.target.id
      var sorted_todos = $('#'+frame).sortable('toArray')
      $.post("todos/set_sorting", {sorted_todos: sorted_todos, frame: frame})
      //alert(event.target.id) 
      //debugger
  	},
  	receive: function(event, ui) { 
  	  //alert('receive')
  	  //debugger
  	  var droppedElement = event.srcElement.id 
  	  var newFrame = event.target.id
  	  //var result = $('#'+newFrame).sortable('toArray')
  	  //alert(result[0])
  	  //alert(result[1])
  	  
  	  $.post("todos/set_frame", { id: droppedElement, frame: newFrame } )
  	},
    
  }).disableSelection()
    
  
  //
  // Rename functionality
  //
  $('.rename_todo_text').live('keyup', function(e) {    
    if (e.which == 13) { saveHandler() } 
    if (e.which == 27) { cancelHandler() }
  })
  function saveHandler() { 
    var newTitle = $.trim($(".rename_todo_text").val())
    if (newTitle.length == 0)
      return
    var id = $(".rename_todo_id").val()
    $.post("todos/rename", { id: id, title: newTitle})
    $('#'+id).text(newTitle)
  }
  function cancelHandler() {
    var originalTitle = $(".rename_todo_original_title").val() 
    var id = $(".rename_todo_id").val()
    $('#'+id).text(originalTitle)
  }
  $('.save_rename').live('click', saveHandler)
  $('.cancel_rename').live('click', cancelHandler)
  // $('.insertedDude').live('click', function() {
  //     saveHandler()
  // })
  
  $(".frame_item").dblclick(function() {
    var text = $.trim($(this).text())
    var id = $(this).attr('id')
    $(this).text('')
    $('<input type="hidden" class="rename_todo_original_title">').appendTo($(this)).val(text)
    $('<input type="hidden" class="rename_todo_id">').appendTo($(this)).val(id)

    $('<input type="text" class="rename_todo_text" size="55"/>').appendTo($(this)).val(text).select()
    $('<span class="save_rename">Save</span>').appendTo($(this))
    $('<span class="cancel_rename">Cancel</span>').appendTo($(this))      
  })  
   
})
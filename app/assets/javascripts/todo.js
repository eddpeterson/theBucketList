$(function() {
  $(".new_todo_button").click(function() {
    frame_context = $(this).parent().parent()
    frame = frame_context.attr('id')
    //alert(frame)
    title = $("#new_title", frame_context).val()
    //alert(new_title)
    $.post(
      "todos/", 
      {title: title, frame: frame}, 
      function(data) { 
        //alert(data._id)
        $("#"+frame).prepend('<li>wadaaa</li>')
      })
  })
  
  		
  $( "#none, #personal, #family, #friends, #work, #social" ).sortable({
    connectWith: ".frame",
    opacity: 0.35,
    placeholder: "ui-state-highlight",
    hoverClass: "ui-state-hover",
    update: function(event, ui) { 
      var frame = event.target.id
      
      var sorted_todos = new Array(); //$('#'+frame).sortable('toArray')
      frame_context = $('#'+frame)
      $('.frame_item', frame_context).each(function(index){sorted_todos[index] = ($(this).attr('id'))})
      
      //debugger
      //alert(sorted_todos.count)
      //alert(sorted_todos[0])
      $.post("todos/set_sorting", {sorted_todos: sorted_todos, frame: frame})
      
    },
    //receive: function(event, ui) { 
      //alert('receive')
      //debugger
      //var droppedElement = event.srcElement.parent().attr('id') 
      //alert(droppedElement)
      //var newFrame = event.target.id
      //var result = $('#'+newFrame).sortable('toArray')
      //alert(result[0])
      //alert(result[1])

      //$.post("todos/set_frame", { id: droppedElement, frame: newFrame } )
    //},

  }).disableSelection()
 


  //
  // Rename functionality
  //
  $('.save_rename').live('click', function(){ saveHandler(frame_item_context = $(this).parent().parent())})
  $('.cancel_rename').live('click', function(){ cancelHandler(frame_item_context = $(this).parent().parent())})
  $('.rename_title').live('keyup', function(e) { 
    if (e.which == 13) { saveHandler(frame_item_context = $(this).parent().parent()) } 
    if (e.which == 27) { cancelHandler(frame_item_context = $(this).parent().parent()) }
  })
  function saveHandler(frame_item_context) { 
    newTitle = $('.rename_title', frame_item_context).val()
    if (newTitle.length == 0)
      return
    
    id = frame_item_context.attr('id')
    $.post("todos/rename", { id: id, title: newTitle})
    
    $(".frame_item_rename", frame_item_context).toggle()
    $(".frame_item_readonly", frame_item_context).toggle()
    $(".frame_item_readonly", frame_item_context).text(newTitle)
    cancelRenameInProgress()
  }
  function cancelHandler(frame_item_context) {
    $(".frame_item_readonly", frame_item_context).toggle()
    $(".frame_item_rename", frame_item_context).toggle()
    cancelRenameInProgress()
  }
  $(".frame_item").dblclick(function() {
    if (isRenameInProgress())
      return
    setRenameInProgress()   
    $(".frame_item_readonly", this).toggle()
    $(".frame_item_rename", this).toggle()
    $('.rename_title').select()     
  })  
  function isRenameInProgress(){
    return $('#is_rename_in_edit_mode').val() == "true"    
  } 
  function setRenameInProgress(){
    $('#is_rename_in_edit_mode').val("true")
  }
  function cancelRenameInProgress(){
    $('#is_rename_in_edit_mode').val("false")
  }


 
  // $(".frame_dude").hoverIntent(
  //        function(e){ 
  //          id = e.target.id
  //          $('.frame_item_mouseover[id="'+ id + '"]').show()
  //          
  //        },
  //        function(e){
  //          
  //          id = e.target.id
  //          $('.frame_item_mouseover[id="'+ id + '"]').hide()
  //          
  //        })
   
  $('.remove_todo').click(function(){
    var id = $(this).parent().parent().attr('id')
    $dialog.data('id', id).dialog('open')
  })
  var $dialog = $( "#dialog-confirm" ).dialog({
    autoOpen: false,
    resizable: false,
    height:200,
    modal: true,
    buttons: {
      Delete: function() {
        id = $(this).data('id')
        $.ajax({
          url: "todos/" + id,
          global: false,
          type: "DELETE",
          //data: {id : this.getAttribute('id')},
          dataType: "html",
          async:false,
          success: function(msg){
            $('.frame_item[id="'+ id + '"]').parent().hide('slow')
          }
        }) 

        $( this ).dialog( "close" );
      },
      Cancel: function() {
        $( this ).dialog( "close" );
      }
    }
  });
   
})
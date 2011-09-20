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
  $('.rename_title').live('keyup', function(e) { 
    if (e.which == 13) { saveHandler($(this).attr('id')) } 
    if (e.which == 27) { cancelHandler($(this).attr('id')) }
  })
  function saveHandler(id) { 
    //id = $(this).attr('id')
    var newTitle = $('.rename_title[id="'+ id + '"]').val()
    if (newTitle.length == 0)
      return
    
    $.post("todos/rename", { id: id, title: newTitle})
    
    $('.frame_item_edit[id="'+ id + '"]').toggle()
    $('.frame_item[id="'+ id + '"]').toggle()
    $('.todo_title[id="'+ id + '"]').text(newTitle)
    
    cancelRenameInProgress()
  }
  function cancelHandler(id) {
    
    $('.frame_item_edit[id="'+ id + '"]').toggle()
    $('.frame_item[id="'+ id + '"]').toggle()
    
    cancelRenameInProgress()
  }
 $('.save_rename').live('click', function(){ saveHandler($(this).attr('id')) })
 $('.cancel_rename').live('click', function(){ cancelHandler($(this).attr('id')) })


  $(".frame_item").dblclick(function() {
    
    if (isRenameInProgress())
      return
    setRenameInProgress()
    
    var text = $.trim($(this).text())
    var id = $(this).attr('id')
    
    
    $('.frame_item_edit[id="'+ id + '"]').toggle()
    $('.frame_item[id="'+ id + '"]').toggle()
    
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


  $('button.remove').click(function(){
    var id = $(this).val()

    $( "#dialog-confirm" ).dialog({
      resizable: false,
      height:200,
      modal: true,
      buttons: {
        Delete: function() {
          $.ajax({
            url: "todos/" + id,
            global: false,
            type: "DELETE",
            //data: {id : this.getAttribute('id')},
            dataType: "html",
            async:false,
            success: function(msg){
              alert('removed')
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
  
   
})
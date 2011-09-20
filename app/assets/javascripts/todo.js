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
      cancelRenameInProgress()
    }
    function cancelHandler() {
      var originalTitle = $(".rename_todo_original_title").val() 
      var id = $(".rename_todo_id").val()
      $('#'+id).text(originalTitle)
      cancelRenameInProgress()
    }
    $('.save_rename').live('click', saveHandler)
    $('.cancel_rename').live('click', cancelHandler)
    // $('.insertedDude').live('click', function() {
      //     saveHandler()
      // })

      $(".frame_item").dblclick(function() {

        if (isRenameInProgress())
        return

        var text = $.trim($(this).text())
        var id = $(this).attr('id')
        $(this).text('')

        // set rename in progress to avoid double click error on textbox
        setRenameInProgress()

        $('<input type="hidden" class="rename_todo_original_title">').appendTo($(this)).val(text)
        $('<input type="hidden" class="rename_todo_id">').appendTo($(this)).val(id)

        $('<input id="rename_todo_text" type="text" class="rename_todo_text" size="55"/>').appendTo($(this)).val(text).select()
        $('<span class="save_rename">Save</span>').appendTo($(this))
        $('<span class="cancel_rename">Cancel</span>').appendTo($(this))      
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
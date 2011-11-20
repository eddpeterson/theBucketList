$(function() {
  
  //
  // Add new goal 
  //
  $('.new_title').live('keyup', function(e) { 
    if (e.which == 13) { add_new_goal(frame_context = $(this).parent()) } 
  })
  $(".new_goal_button").live('click', function() {
    add_new_goal(frame_context = $(this).parent())
  })
  function add_new_goal(frame_context){
    frame = frame_context.attr('id').replace('new_goal_', '')
    //alert(frame)
    title = $.trim($(".new_title", frame_context).val())
    
    if (title.length == 0)
      return
    
    //alert(new_title)
    $.post(
      "goals/", 
      {title: title, frame: frame}, 
      function(data) { 
        //alert(data._id)
        parent = $("#"+frame).parent()
        $("#"+frame).remove()
        parent.append(data)
        update_goals_completeness_percentage()
        //$("#"+frame).prepend('<li>wadaaa</li>')
    })
  
    $(".new_title", frame_context).val("").focus()
  }
  
  
  // 
  // Working with lists
  //
  $("#personal, #family, #friends, #work, #social").livequery(function(){
     $(this).sortable({
       connectWith: ".frame",
       opacity: 0.35,
       placeholder: "ui-state-highlight",
       hoverClass: "ui-state-hover",
       update: function(event, ui) { 
         var frame = event.target.id
         
         var sorted_goals = new Array(); //$('#'+frame).sortable('toArray')
         frame_context = $('#'+frame)
         $('.frame_item', frame_context).each(function(index){sorted_goals[index] = ($(this).attr('id'))})
         
         //debugger
         //alert(sorted_goals.count)
         //alert(sorted_goals[0])
         $.post("goals/set_sorting", {sorted_goals: sorted_goals, frame: frame})
         
       }
     
     }).disableSelection()
  });


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
    newTitle = $.trim($('.rename_title', frame_item_context).val())
    if (newTitle.length == 0)
      return
    
    id = frame_item_context.attr('id')
    $.post("goals/rename", { id: id, title: newTitle})
    
    $(".frame_item_rename", frame_item_context).toggle()
    $(".frame_item_readonly", frame_item_context).toggle()
    $(".title", frame_item_context).text(newTitle)
    cancelRenameInProgress()
  }
  function cancelHandler(frame_item_context) {
    $(".frame_item_readonly", frame_item_context).toggle()
    $(".frame_item_rename", frame_item_context).toggle()
    cancelRenameInProgress()
  }
  $(".frame_item").live('dblclick', function() {
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
  
  
  // 
  // Delete functionality
  //
  $(".frame_item").live('mouseenter', 
    function () {
      id = $(this).attr('id')
      $(this).append($("<span class='remove_goal' id=" + id +  ">Remove</span>"));
    }
  );
  $(".frame_item").live('mouseleave',  
    function () {
      $(this).find("span:last").remove();
    }
  );
  $('.remove_goal').live('click', function(){
    var id = $(this).attr('id')
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
          url: "goals/" + id,
          global: false,
          type: "DELETE",
          //data: {id : this.getAttribute('id')},
          dataType: "html",
          async:false,
          success: function(msg){
            $('.frame_item[id="'+ id + '"]').parent().remove()
            update_goals_completeness_percentage()
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
$(function() {
        
  $( "#none, #personal, #family, #friends, #work, #social" ).sortable({
  	connectWith: ".frame",
  	opacity: 0.45,
  	update: function(event, ui) { 
  	  var frame = event.target.id;
      var sorted_todos = $('#'+frame).sortable('toArray');
      $.post("todos/set_sorting", {sorted_todos: sorted_todos, frame: frame});
      //alert(event.target.id); 
      //debugger;
  	},
  	receive: function(event, ui) { 
  	  //alert('receive')
  	  //debugger;
  	  var droppedElement = event.srcElement.id; 
  	  var newFrame = event.target.id;
  	  //var result = $('#'+newFrame).sortable('toArray');
  	  //alert(result[0]);
  	  //alert(result[1]);
  	  
  	  $.post("todos/set_frame", { id: droppedElement, frame: newFrame } );
  	},
    
  }).disableSelection();
    
  $(".frame_item").dblclick(function() {
    var text = $.trim($(this).text());
    var id = $(this).attr('id');
    $(this).text('');
    $('<input type="text" class="rename_todo" size="55"/>').appendTo($(this)).val(text).select().blur(
      function(){
        var newText = $(this).val();
        $.post("todos/rename", { id: id, title: newText});
        $(this).parent().text(newText).find('input:text').remove();
      });
  });  
    // $("ul.frame").each(function(){      
    //       $('#'+this.id).sortable({revert:true});
    //     })  
    //  
    //    
    //    $( "li.frame" ).draggable({
    //      opacity: 0.45,
    //      connectToSortable: "*", // allows to drag to any sortalbe list
    //      //helper: "clone",
    //      //revert: false,
    //      stop: function(event, ui) { 
    //        alert(this.parentNode.id);
    // //debugger;
    //        alert(ui);
    //        }
    //      // stop: function() {
    //      //                    alert('add new frame' + this.id);
    //      //                    alert(this.parent.id)
    //      //                  }
    //    });
    //    
    //    $( "ul, li" ).disableSelection();
	});
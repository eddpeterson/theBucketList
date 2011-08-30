$(function() {
        
  $( "#frame_none, #frame_personal, #frame_family, #frame_friends, #frame_work, #frame_social" ).sortable({
  	connectWith: ".frame",
  	opacity: 0.45,
  	update: function(event, ui) { 
  	  //alert(event.target.id); 
      //debugger;
  	},
  	receive: function(event, ui) { 
  	  //alert('receive')
  	  //debugger;
  	  var droppedElement = event.srcElement.id; 
  	  var newFrame = event.target.id;
  	},
    
  }).disableSelection();
    
    	
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
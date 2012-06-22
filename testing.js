var response="";
var score="";
var hintstr="";
$(document).ready( function(){
  $('.Qproblem').prepend("<span class='QhintShow'></span>");
  // Click handler for a choice
  $('.Qset .Qchoice').click( function(event) {
    var ntries=0; 
    var nright=0;
    // Unhighlight the others
    $(this).siblings('.Qchoice').removeClass("Qselected");
    // Highlight this one
    $(this).addClass("Qselected");
    if ($(this).children('.Qright').text() == 'No'){
      $(this).addClass("QwrongChoice");
      response=$(this).children('.Qhint').text(); // Hint 
      if (response.length > 0 ) { // Show hint if it's there.
        response="Hint: ".concat(response);
        $('.QhintShow').text(response);
      }
      
    }
    if ($(this).children('.Qright').text() == 'Yes'){
      $(this).addClass("QgotIt")
      response = " ";
      $(this).siblings('.QhintShow').text(response);
    } 
    // Mark the item as selected
    $(this).addClass("QuserPickedMe");
    // Find the number of tries
    $(this).parent().children('.QuserPickedMe').each(function(index){
      ntries++;
    })
    // Find the number that were right
    $(this).parent().children('.QgotIt').each(function(index){
      nright++;
    })
    
    //score = "Score: ".concat(nright, " right in ", ntries, " tries.");
    //$(this).siblings('.Qscore').text(score);
    var totalright=0;
    var totaltries=0;
    $('.QuserPickedMe').each(function(index){
      totaltries++;
    })
    $('.QgotIt').each(function(index){
      totalright++;
    })
    $('.QpageHeader').text("Overall score: ".concat(totalright, " right in ",totaltries, " tries."))
  })
})
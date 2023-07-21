// var i = 0;

// $("#yes").click(function () {
//     if (i < 1) {
//         $('#optional-field').append('<input type="text" class="form-control" id="optional" name="optional" placeholder=" Enter here" required />');
//         i = 1;
//     }
// });
// $("#no").click(function () {

//     $('#optional').remove();
//     i = 0;
// });



$(document).ready(function () {
    $('body').bind('cut copy paste drag drop selectstart', function (event) {
        event.preventDefault();
    });
});

$('textarea').keydown(function (e) {
  
  
    if($("#answer").val() != ""){
        $(".ans-error").remove();
        /*$("#answer").css("border","1px solid gray" );*/
    }
    // $("#answer").css( "outline","none");
    let target = e.currentTarget;
    let words = target.value.split(/\s+/).length;
   $("#count").html((90 - parseInt(words)));
    if (words >= 90) {
        if (e.keyCode == 8) {
            return true;
        } else {
            e.preventDefault();
        }
    }
});



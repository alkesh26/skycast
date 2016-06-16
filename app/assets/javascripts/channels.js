$(function(){

  var valid_form = function(){
    var lowest_channel = parseInt($("#lowest_channel").val());
    var highest_channel = parseInt($("#highest_channel").val());
    var blocked_channel_size = parseInt($("#blocked_channel_size").val());
    var browsing_channel_size = parseInt($("#browsing_channel_size").val());
    var blocked_channels = $("#blocked_channels").val().split(' ') || [];
    var browsing_channels = $("#browsing_channels").val().split(' ') || [];

    if(!$.isNumeric(lowest_channel) || lowest_channel < 1){
      alert('Lowest channel is incorrect');

      return false;
    }

    if(!$.isNumeric(highest_channel) || highest_channel > 10000 || highest_channel < lowest_channel){
      alert('Highest channel is incorrect');
      return false;
    }

    if(!$.isNumeric(blocked_channel_size) || blocked_channel_size < 0 || blocked_channel_size > 40){
      alert('Blocked channel size should be greater than equal to 0');
      return false;
    }

    if(!$.isNumeric(browsing_channel_size) || browsing_channel_size < 1 || browsing_channel_size > 50){
      alert('Browsing channel size should be greater than equal to 1 and less than equal to 50');
      return false;
    }

    if(blocked_channel_size != 0 && blocked_channel_size != blocked_channels.length){
      alert('Blocked channel size does not match with the number of blocked channels');
      return false;
    }

    if(browsing_channel_size != browsing_channels.length){
      alert('Browsing channel size does not match with the number of Browsing channels');
      return false;
    }
    return true;
  }

  $("#channel_form").submit(function(e){
    e.preventDefault();
    if(valid_form()){
      var form = $(this);
      $("#count").empty();
      $("#error").empty();
      $.ajax({
        url: form.attr('action'),
        type: form.attr('method'),
        data: form.serialize(),
        success: function(response){
          console.log(response);
          $("#count").text('Minimum number of clicks in which channels can be surfed is ' + response.minimum_count);
        },
        error: function(response){
          $("#error").text(response.responseJSON.errors);
        }
      });
    }
  });

});
//= require cable
//= require_self
//= require_tree .

App.cable = Cable.createConsumer('ws://127.0.0.1:28080');
App.messages = App.cable.subscriptions.create('MessagesChannel', {

  received: function(data) {

    var template = data.html

    if (data.update == true) {
      $('#' + data.message_id).text('');
      $('#' + data.message_id).append(template);
      $('.edit_message_' + data.message_id).css('display', 'none');
      return 0
    }

    if (username != data.username) {
      var template = template.replace('img src', 'empty');
      console.log(template)
    }

    if (window.location == 'http://0.0.0.0:3000/rooms/' + data.room_id) {
      $(".messages").append(template);
    }


    $(".chat_log").scrollTop($(".chat_log")[0].scrollHeight);
    $('#message_input').val('');


    $(document).ready(App.showEditMessage);
    $(document).ready(App.hideEditMessage);

  }
});

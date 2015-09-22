//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = Cable.createConsumer('ws://127.0.0.1:28080');
App.messages = App.cable.subscriptions.create('MessagesChannel', {


  received: function(data) {

    if (data.update == true) {
      document.getElementById(data.message_id).textContent = '✎ ' + data.message;
      $('.edit_message_' + data.message_id).css('display', 'none')
      return 0
    }

    if (window.location == 'http://0.0.0.0:3000/rooms/' + data.room_id) {
      var template =
      "<p class='message'>" +
        "<b>" +
          "[" + data.timestamp + "] " +
          data.username + ": " +
        "</b>" +
        "<span id='" + data.message_id + "'>" +
          data.message +
        "</span>" +
        "<button id='show_edit_message_" + data.message_id + "'>" +
          "<img src='/assets/gear.png'>" +
        "</button>" +

        "<div class='edit_message_" + data.message_id + "'>" +
          "<form class='edit_message' id='edit_message_" + data.message_id + "' action='/rooms/" + data.room_id + "/messages/" + data.message_id + "' data-remote='true' method='post'>" +
          "<input name='utf8' type='hidden' value='" + data.message + "' />" +
          "<input type='hidden' name='_method' value='patch' />" +
          "<input value='' placeholder='Edit  " + "`" + data.message + "`" + "' type='text' name='message[text]' id='message_text' />" +
          "<input type='submit' name='commit' value='Update Message' />" +
          "<button type='button' id='close_edit_message_" + data.message_id + "'>Cancel</button>" +
          "<p></p>" +
        "</div>" +
      "</p>"

      $(".messages").append(template);
    }

    $(".chat_log").scrollTop($(".chat_log")[0].scrollHeight);
    $('#message_input').val('');

    if (username == data.username) {
      $('.message').on('mouseover', function(event) {
        $('#show_edit_message').css('display', 'block');
      });
    }

    $(document).ready(show_edit_message);
    $(document).ready(hide_edit_message);

  }
});

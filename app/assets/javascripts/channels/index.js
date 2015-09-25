//= require cable
//= require_self
//= require_tree .

$(function() {
  $('[data-messages-url]').each(function() {
    App.cable = Cable.createConsumer($(this).data('messages-url'));
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

        $(".messages").append(template);

        $(".chat_log").scrollTop($(".chat_log")[0].scrollHeight);
        $('#message_input').val('');


        $(document).ready(App.showEditMessage);
        $(document).ready(App.hideEditMessage);

      }
    });
  });
});

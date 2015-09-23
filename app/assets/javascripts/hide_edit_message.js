App.hideEditMessage = function() {
  $('[id^=close_edit_message_]').on('click', function() {
    $('.' + this.id.replace('close_', '')).css('display', 'none');
   });
};

$(document).ready(App.hideEditMessage);

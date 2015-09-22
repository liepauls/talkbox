hide_edit_message = function() {
  $('[id^=close_edit_message_]').on('click', function() {
    $('.' + this.id.replace('close_', '')).css('display', 'none');
   });
};

$(document).ready(hide_edit_message);

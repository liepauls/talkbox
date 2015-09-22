show_edit_message = function() {
  $('[id^=show_edit_message_]').on('click', function() {
    $('.' + this.id.replace('show_', '')).css('display', 'block');
  });
};

$(document).ready(show_edit_message);

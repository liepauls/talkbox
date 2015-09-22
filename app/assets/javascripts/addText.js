$(document).ready(function() {
  $('[id^=add_]').on('click', function() {
    document.getElementById('message_input').value += this.id.replace('add_', '')
  })
});

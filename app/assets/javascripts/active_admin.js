//= require arctic_admin/base
import "@fortawesome/fontawesome-free/css/all.css";
import 'arctic_admin'

$(document).ready(function() {
  // Add toggle functionality for password input
  $('#password_input').after('<span class="toggle-password">&#128065;</span>');
  $('#password_confirmation_input').after('<span class="toggle-password">&#128065;</span>');

  $(document).on('click', '.toggle-password', function() {
    const inputField = $(this).prev('input');
    const type = inputField.attr('type') === 'password' ? 'text' : 'password';
    inputField.attr('type', type);
  });
});

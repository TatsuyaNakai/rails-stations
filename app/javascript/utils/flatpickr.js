import flatpickr from 'flatpickr';
import 'flatpickr/dist/flatpickr.min.css';

document.addEventListener('turbolinks:load', function () {
  flatpickr('.datetimepicker', {
    enableTime: true,
    dateFormat: 'Y-m-d H:i',
  });

  flatpickr('.datepicker', {
    dateFormat: 'Y-m-d',
  });
});

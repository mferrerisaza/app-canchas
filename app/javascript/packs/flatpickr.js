import flatpickr from "flatpickr";
import confirmDatePlugin from 'flatpickr/dist/plugins/confirmDate/confirmDate';

import "flatpickr/dist/flatpickr.min.css";
// import 'flatpickr/dist/plugins/confirmDate/confirmDate.css';
// import "flatpickr/dist/themes/airbnb.css";

flatpickr(".datepicker", {
  minDate: "today",
  altInput: true
  // maxDate: new Date().fp_incr(15),
});

import flatpickr from "flatpickr";
import confirmDatePlugin from 'flatpickr/dist/plugins/confirmDate/confirmDate';

import "flatpickr/dist/flatpickr.min.css";
import "flatpickr/dist/themes/airbnb.css";
import 'flatpickr/dist/plugins/confirmDate/confirmDate.css';

flatpickr(".datepicker", {
  minDate: "today",
  // maxDate: new Date().fp_incr(15),
  altInput: true,
  mode: "range",
  plugins: [new confirmDatePlugin({
    confirmIcon: "<i class='fa fa-check'></i>",
    confirmText: "OK ",
    showAlways: true,
    theme: "airbnb"
  })]
});

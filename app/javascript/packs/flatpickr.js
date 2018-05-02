import flatpickr from "flatpickr";
import confirmDatePlugin from 'flatpickr/dist/plugins/confirmDate/confirmDate';

import "flatpickr/dist/flatpickr.min.css";
import "flatpickr/dist/themes/material_green.css";
import 'flatpickr/dist/plugins/confirmDate/confirmDate.css';

flatpickr(".datepicker", {
  minDate: "today",
  altInput: true,
  mode: "range",
  plugins: [new confirmDatePlugin({
    confirmIcon: "<i class='fa fa-check'></i>",
    confirmText: "OK ",
    showAlways: true,
    theme: "light"
  })]
});

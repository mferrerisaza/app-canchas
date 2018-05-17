import noUiSlider from 'nouislider';
import "nouislider/distribute/nouislider.min.css";

const formatHour = (value) => {
  value = parseInt(value, 10)
  if (value === 24) {
      return `${value - 12} AM`
  } else if (value === 12){
      return `${value} PM`
  } else if (value > 12){
      return `${value - 12} PM`
  } else {
      return `${value} AM`
  }
}

const unFormatHour = (value) => {
  if (value === '12 AM') {
      return 24
  } else if (value === '12 PM'){
      return 12
  }  else {
      const myArray = value.split(' ')
      if (myArray[1] === "PM") {
        return parseInt(myArray[0], 10) + 12
      }
      else {
        return parseInt(myArray[0], 10)
      }
  }
}

const slider = document.getElementById('slider');

noUiSlider.create(slider, {
  start: ["5 PM", "11 PM"],
  step: 1,
  connect: true,
  behaviour: 'tap',
  format: {
    to: (value) => formatHour(value),
    from: (value) => unFormatHour(value)
  },
  tooltips: true,
  margin: 1,
  range: {
    'min': 1,
    'max': 23
  }
});

var inputFormat1 = document.getElementById('starttime');
var inputFormat2 = document.getElementById('endtime');

slider.noUiSlider.on('update', function( values, handle ) {
  inputFormat1.value = unFormatHour(values[0]);
  inputFormat2.value = unFormatHour(values[1]);
});

document.addEventListener("DOMContentLoaded", () => {
  const params = new URLSearchParams(window.location.search)
  slider.noUiSlider.set([parseInt(params.get("start_time"), 10), parseInt(params.get("end_time"), 10)]);
})


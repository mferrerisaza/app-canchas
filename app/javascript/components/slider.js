import noUiSlider from 'nouislider';
import "nouislider/distribute/nouislider.min.css";

function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
}

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

function createSlider(slider, inputFormat1, inputFormat2){
  noUiSlider.create(slider, {
    start: ["1 AM", "11 PM"],
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
  slider.noUiSlider.on('update', function( values, handle ) {
    inputFormat1.value = unFormatHour(values[0]);
    inputFormat2.value = unFormatHour(values[1]);
    const hoursDropdown = document.getElementById("search-hours-dropdown");
    const boolean = values[0] === "1 AM" && values[1] === "11 PM"
    if (hoursDropdown && !boolean) {
      hoursDropdown.innerHTML = `${values[0]} - ${values[1]}`
    } else if (hoursDropdown) {
      hoursDropdown.innerHTML = `Horarios`
    }
  });
}



document.addEventListener("DOMContentLoaded", () => {
  const sliderDiv = document.getElementById('slider');
  const inputFormat1 = document.getElementById('starttime');
  const inputFormat2 = document.getElementById('endtime');

  if (sliderDiv) {
    createSlider(sliderDiv, inputFormat1, inputFormat2);
    sliderDiv.noUiSlider.set([parseInt(getUrlParameter("start_time"), 10), parseInt(getUrlParameter("end_time"), 10)]);
  }
})


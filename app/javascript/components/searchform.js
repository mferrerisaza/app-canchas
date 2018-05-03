const range = (start, end) => Array.from({length: (end - start)}, (v, k) => k + start);

const formatHour = (value) => {
  if (value === 24) {
    return `${value - 12}  AM`
  } else if (value === 12){
    return `${value}  PM`
  } else if (value > 12){
    return `${value - 12}  PM`
  } else {
    return `${value} AM`
  }
}

const removeEndTimeOptions = (event) => {
  const endTimeInput = document.getElementById("endtime");
  const timeRange = range(parseInt(event.currentTarget.value,10) + 1, 24);
  if(event.currentTarget.value !== ""){
    endTimeInput.innerHTML=""
      endTimeInput.disabled = false
      endTimeInput.insertAdjacentHTML("beforeend", `<option selected disabled hidden>Y 8PM</option>`)
      timeRange.forEach((time) => {
        htmlText = `<option value="${time}">${formatHour(time)}</option>`
        endTimeInput.insertAdjacentHTML("beforeend", htmlText)
    })
  }
}

function selectTimePickers() {
  const startTimeInput = document.getElementById("starttime");
  const endTimeInput = document.getElementById("endtime");
  startTimeInput.addEventListener("click", removeEndTimeOptions)
}


document.addEventListener("DOMContentLoaded", () => {
  selectTimePickers();
})



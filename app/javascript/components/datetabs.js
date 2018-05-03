const fetchSchedule = (event) => {
  const query = document.getElementById("query").value;
  const capacityLimit = parseInt(document.getElementById("capacity_limit").value, 10);
  const dates = event.currentTarget.dataset.date;
  const startTime = document.getElementById("starttime").value;
  const endTime = document.getElementById("endtime").value;

  fetch(`/schedule?utf8=✓&query=${query}&capacity_limit=${capacityLimit}&dates=${dates}&start_time=${startTime}&end_time=${endTime}`)
  .then(response => response.json())
  .then((data) => {
    console.log(data);
  });
}

const generateFieldCards = (event) => {
  document.querySelector(".cards-container").innerHTML = "";
  const test = fetchSchedule(event);
  console.log(test);
}

const removeTabUnderline = (element) => {
  element.classList.remove("active-date");
}

const addTabUnderline = (event) => {
  const tabs = Array.from(event.currentTarget.parentNode.children);
  tabs.forEach(removeTabUnderline);
  event.currentTarget.classList.add("active-date");
  document.getElementById("dropdownMenu1").innerHTML = `${event.currentTarget.innerText} <span class="caret"></span>`
  generateFieldCards(event);
};

const addTabListeners = (element) => {
  element.style.cursor = "pointer";
  element.addEventListener("click",
    addTabUnderline
  );
};

function selectDateTabs() {
  document.querySelectorAll(".date-tab").forEach(addTabListeners);
}


document.addEventListener("DOMContentLoaded", () => {
  selectDateTabs();
})



var cloudinary = require('cloudinary');

function buildFieldCard (field, schedule) {
  const text = `<div class="col-xs-12 col-sm-6">
        <div class="card">
          <div class="card-top"> ${cloudinary.image("${field.photo.url")}
          </div>
          <div class="card-bottom">
            <div class="card-business-name">
              ${field.business.name}
            </div>
            <div class="card-field-name">
              ${field.name}
            </div>
            <div class="card-price">
              Precio: ${field.price_cents / 100}
            </div>
            <div class="card-addreess">
              ${field.business.address}
            </div>
            <div class="card-available-hours">
              Disponibilidad:
              ${schedule}
            </div>
            <div class="card-field-capacity">
              Capacidad de la cancha: ${field.capacity} jugadores (${field.capacity / 2} vs. ${field.capacity / 2})
            </div>
            <div class="disponibilidad">
              <div>Desea dividir la tarifa entre todos los jugadores?</div>
              <div class="card-toggle-btn" id="toggle ${field.id} ">
                render 'shared/toggle_switch'
              </div>
            </div>
            <div class="card-cta" data-id= ${field.id}>
              <a class="btn btn-cta" data-toggle="modal" data-target="#myModal" href="">Reservar</a>
            </div>
            render 'shared/booking_modal'
          </div>
        </div>
      </div>`
  document.querySelector(".cards-container").insertAdjacentHTML("beforeend", text);
}
function fetchFieldInfo (fieldId, callback) {
  fetch('/fields/' + fieldId)
  .then(response => response.json())
  .then((data) => {
    callback(data);
  });
}

function retriveFieldCardInfo (fields) {
  Object.keys(fields).forEach((key) => {
    fetchFieldInfo(key, (data) => {
      buildFieldCard(data, fields[key]);
    })
  });
}

function fetchSchedule (event, callback) {
  const query = document.getElementById("query").value;
  const capacityLimit = document.getElementById("capacity_limit").value;
  const dates = event.currentTarget.dataset.date;
  const startTime = document.getElementById("starttime").value;
  const endTime = document.getElementById("endtime").value;

  fetch(`/schedule?utf8=✓&query=${query}&capacity_limit=${capacityLimit}&dates=${dates}&start_time=${startTime}&end_time=${endTime}`)
  .then(response => response.json())
  .then((data) => {
    callback(data[dates]);
  });
}

const clearTheDOM = (event) => {
  document.querySelector(".cards-container").innerHTML = "";
}

const removeTabUnderline = (element) => {
  element.classList.remove("active-date");
}

const addTabUnderline = (event) => {
  const tabs = Array.from(event.currentTarget.parentNode.children);
  tabs.forEach(removeTabUnderline);
  event.currentTarget.classList.add("active-date");
  document.getElementById("dropdownMenu1").innerHTML = `${event.currentTarget.innerText} <span class="caret"></span>`
  clearTheDOM(event);
  fetchSchedule(event, retriveFieldCardInfo);
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



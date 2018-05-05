import selectCtaButtons from './getmodalinfo'
var cloudinary = require('cloudinary');

const buildScheduleBtns = (schedule) => {
  let html = ""
  Object.keys(schedule).forEach((key) => {
    html = html +
    `<label class="schedule-btn btn btn-primary btn-xs">
      <input type="radio" name="options" autocomplete="off">
      ${key} - ${(parseInt(key, 10) + 1).toString()}
    </label>`
  })
  return html
}

function buildFieldCard (field, schedule) {
  const text = `<div class="col-xs-12 col-sm-6">
        <div class="card">
          <div class="card-top"> ${cloudinary.image(field.photo.url, {aspect_ratio: "3:1", gravity: "auto", width: 285, crop: "fill", fetch_format: "auto"})}
          </div>
          <div class="card-bottom">
            <div class="card-business-name">
              ${field.business.name}
            </div>
            <div class="card-field-name">
              ${field.name}
            </div>
            <div class="card-price">
              Precio: $${(field.price_cents/100).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')}
            </div>
            <div class="card-addreess">
              ${field.business.address}
            </div>
            <div class="card-available-hours">
              Disponibilidad:
              <div class="schedule-container">
                <div class="btn-group btn-group-toggle" data-toggle="buttons">
                  ${buildScheduleBtns(schedule)}
                </div>
              </div>
            </div>
            <div class="card-field-capacity">
              Capacidad de la cancha: ${field.capacity} jugadores (${Math.floor(field.capacity / 2)} vs. ${Math.floor(field.capacity / 2)})
            </div>
            <div class="disponibilidad">
              <div>Desea dividir la tarifa entre todos los jugadores?</div>
              <div class="card-toggle-btn" id="toggle${field.id}">
                <div class="card-toggle">
                  <div>
                    <label class="switch">
                      <input class="splitable" type="checkbox">
                      <span class="slider round"></span>
                    </label>
                  </div>
                </div>
              </div>
            </div>
            <button name="button" type="submit" class="card-cta btn btn-cta" data-id="${field.id}" data-toggle="modal" data-target="#myModal">
              Reservar
            </button>
            <div id="myModal" class="modal fade" role="dialog">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" id="modal-close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirmación de reserva</h4>
                  </div>
                  <div class="modal-body">
                    <div class="modal-business-name">
                    </div>
                    <div class="modal-field-name">
                    </div>
                    <div class="modal-selected-hour">
                    </div>
                    <div class="modal-business-address">
                    </div>
                    <div class="modal-splitable">
                    </div>
                    <div class="modal-capacity">
                    </div>
                    <div class="modal-price">
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                  </div>
                </div>
              </div>
            </div>
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
  document.querySelector("body").style.cursor="progress";
  Object.keys(fields).forEach((key) => {
    fetchFieldInfo(key, (data) => {
      buildFieldCard(data, fields[key]);
    })
  });
  setTimeout( () => { document.querySelector("body").style.cursor = "default"},500)
  setTimeout(selectCtaButtons, 1000);
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



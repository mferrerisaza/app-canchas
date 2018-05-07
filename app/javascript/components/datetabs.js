import selectCtaButtons from './getmodalinfo'
import { retriveDropdowns, retriveTimeBtns } from './field-card.js'
var cloudinary = require('cloudinary');

const buildScheduleBtns = (schedule, date) => {
  let html = ""
  Object.keys(schedule).forEach((key) => {
    html = html +
    `<label class="schedule-btn btn btn-xs">
      <input
        type="radio"
        name="options"
        autocomplete="off"
        data-time="${key}"
        value= "${date}"
      >
      ${key} - ${(parseInt(key, 10) + 1).toString()}
    </label>`
  })
  return html
}

function fieldPictureOrGeneric(field) {
  let url = ""
  if(field.photo.url !== null) {
    url = cloudinary.url(field.photo.url, {height: 800, width: 800, crop: "fit"})
  } else {
    url = cloudinary.url("fieldplaceholder.jpg", {height: 800, width: 800, crop: "fit"})
  }
  return url
}

function businessLogoOrGeneric(business) {
  let url = ""
  if(business.photo.url) {
    url = cloudinary.image(business.photo.url, { height: 300, width: 300, crop: "fill", gravity: "face", class: "card-top-business-logo" })
  } else {
    url = cloudinary.image("defaul-logo.png", { height: 300, width: 300, crop: "fill", gravity: "face", class: "card-top-business-logo" })
  }
  return url
}

function buildFieldCard (field, schedule, date) {
  const text =
              `<div class="col-xs-12 col-sm-6">
                <div class="card">
                  <div
                    class="card-top"
                    style="background-image:
                      linear-gradient(rgba(255,255,255, 0),
                      rgba(0, 0, 0, 0.4)),
                      url(${fieldPictureOrGeneric(field)});"
                  >
                     ${businessLogoOrGeneric(field.business)}
                  </div>
                  <div class="card-bottom">
                    <div class="card-header">
                      <h3 class="card-business-name">${field.business.name}</h3>
                      <p class="card-addreess">${field.business.address}</p>
                    </div>
                    <div class="card-field-info">
                      <div class="card-field-descripton">
                        <p class="card-field-name">
                          <i class="fas fa-futbol"></i>
                          ${field.name}
                        </p>
                        <div class="card-field-capacity">
                          <i class="fas fa-users"></i>
                          <p>${field.capacity} jugadores (${field.capacity / 2} vs. ${field.capacity / 2})</p>
                        </div>
                      </div>
                        <p class="card-price">
                          <i class="fas fa-dollar-sign"></i>
                           ${(field.price_cents/100).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')} / Hora
                        </p>
                    </div>
                    <div class="schedule-dropdown">
                      <p>VER HORARIOS</p>
                      <i class="fas fa-chevron-circle-down"></i>
                    </div >
                    <div class="card-available-hours card-collapsed">
                      <hr class="card-line-divider">
                      <i class="far fa-clock"></i>
                      Selecciona uno de los horarios disponibles:
                      <div class="schedule-container">
                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                          ${buildScheduleBtns(schedule, date)}
                        </div>
                      </div>
                      <div class="card-bottom-footer">
                        <button
                          name="button"
                          type="submit"
                          class="card-cta btn btn-cta"
                          data-id="${field.id}"
                          data-toggle="modal"
                          data-target="#myModal"
                          disabled = "disabled"
                        >
                          NO HA SELECCIONADO NINGÚN HORARIO
                        </button>
                      </div>
                    </div>
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
                            <button type="button" class="btn btn-primary" data-dismiss="modal">Confirmar Reserva</button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>`

  document.querySelector(".cards-container").querySelector(".row").insertAdjacentHTML("beforeend", text);
}
function fetchFieldInfo (fieldId, callback) {
  fetch('/fields/' + fieldId)
  .then(response => response.json())
  .then((data) => {
    callback(data);
  });
}

function retriveFieldCardInfo (fields, tabDate) {
  document.querySelector("body").style.cursor="progress";
  Object.keys(fields).forEach((key) => {
    fetchFieldInfo(key, (data) => {
      buildFieldCard(data, fields[key], tabDate);
    })
  });
  setTimeout( () => { document.querySelector("body").style.cursor = "default"},500);
  setTimeout(selectCtaButtons, 1000);
  setTimeout(retriveDropdowns, 1000);
  setTimeout(retriveTimeBtns, 1000);
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
    callback(data[dates], dates);
  });
}

const clearTheDOM = (event) => {
  document.querySelector(".cards-container").querySelector(".row").innerHTML = "";
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



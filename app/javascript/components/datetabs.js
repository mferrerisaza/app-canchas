import selectCtaButtons from './getmodalinfo'
import { retriveDropdowns, retriveTimeBtns } from './field-card.js'
import insertMapOnDOM from '../packs/map.js'
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
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
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

                        <form action="/bookings" method="post">
                        <input type="hidden" name="authenticity_token" value="${token}">

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
                              <input type="hidden" name="booking[field_id]" id="field_id"/>
                              <input type="hidden" name="booking[date]" id="bookingDate"/>
                              <input type="hidden" name="booking[splitable]" id="splitable"/>
                              <input type="hidden" name="booking[number_players]" id="number_players"/>
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                              <button id="submit-button-modal" type="submit" class="btn btn-primary">Confirmar Reserva</button>
                            </div>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
              </div>`

  return text
}

function fetchFieldInfo (callback) {
  fetch('/fields/all')
  .then(response => response.json())
  .then((data) => {
    callback(data);
  });
}
export function retriveFieldCardInfo (fields, tabDate, whoCall) {
  let text = "";
  let markers = [];
  fetchFieldInfo((data) => {
    Object.keys(fields).forEach((key) => {
      const field = data.find(item => item.id === parseInt(key,10))
      text += buildFieldCard(field, fields[key], tabDate);
      markers.push
      (
        { "lat": field.business.latitude,
        "lng": field.business.longitude }
      )
    });
    // Esto remueve los duplicados en los markers
    // Internet ayudo, y no lo entiendo 100% pero basicamente:
    // Lo que hace es dejar solo el primer elemento que tenga esa lat y lng
    markers = markers.filter((marker, index, self) =>
      index === self.findIndex((t) => (
        t.lat === marker.lat && t.lng === marker.lng
      ))
    )
    const mapElement = document.getElementById('map')
    mapElement.dataset.markers = JSON.stringify(markers);
    const isMobileTab = document.querySelector(".active-date").classList.contains("mobile-tab");

    if(whoCall === "tab" && isMobileTab===false ) {
      insertMapOnDOM();
    } else {
      clearTheDOM();
    }
    document.querySelector(".cards-container").querySelector(".row").insertAdjacentHTML("beforeend", text);
    setTimeout(() => { document.querySelector(".loader-div").style.visibility = "hidden" }, 1000);
    selectCtaButtons();
    retriveDropdowns();
    retriveTimeBtns();
  })
}

export function fetchSchedule (bounds, callback, whoCall) {
  const query = document.getElementById("query").value;
  const capacityLimit = document.getElementById("capacity_limit").value;
  const dates = document.querySelector(".active-date").dataset.date;
  const startTime = document.getElementById("starttime").value;
  const endTime = document.getElementById("endtime").value;
  let max_lat = "";
  let min_lat = "";
  let min_lng = "";
  let max_lng = ""
  if (bounds !== "") {
     max_lat = bounds.f.f;
     min_lat = bounds.f.b;
     min_lng = bounds.b.b;
     max_lng = bounds.b.f;
  }
  fetch(`/schedule?utf8=✓&query=${query}&capacity_limit=${capacityLimit}&dates=${dates}&start_time=${startTime}&end_time=${endTime}&min_lng=${min_lng}&max_lng=${max_lng}&min_lat=${min_lat}&max_lat=${max_lat}`)
  .then(response => response.json())
  .then((data) => {
    callback(data[dates], dates, whoCall);
  });
}

const clearTheDOM = () => {
  document.querySelector(".cards-container").querySelector(".row").innerHTML = "";
}

const removeTabUnderline = (element) => {
  element.classList.remove("active-date");
}

const addTabUnderline = (event) => {
  const tabs = document.querySelectorAll(".date-tab");
  tabs.forEach(removeTabUnderline);
  event.currentTarget.classList.add("active-date");
  document.getElementById("dropdownMenu1").innerHTML = `${event.currentTarget.innerText} <span class="caret"></span>`
  document.querySelector(".loader-div").style.visibility = "visible";
  fetchSchedule("", retriveFieldCardInfo, "tab");
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

export default clearTheDOM;

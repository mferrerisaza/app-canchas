const formatHour = (hour)=> {
  if (hour === 12) {
    return `${hour}:00 PM`
  } else if (hour > 12) {
    return `${hour - 12}:00 PM`
  } else {
    return `${hour}:00 AM`
  }
 }

const makeChangesIfToggleChanges = (cardId, modalPrice, price, capacity) => {
  const modalToggleStatus = document.querySelector(".modal-splitable").querySelector(".splitable");
  modalToggleStatus.addEventListener("change", (event) => {
    const modalStatus = event.currentTarget.checked;
    if (modalStatus) {
      modalPrice.innerHTML = "";
      modalPrice.innerHTML = `<i class="fas fa-dollar-sign"></i>${(price/100/capacity).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')} por jugador`;
      document.querySelector("#splitable").value = true;
    } else {
      modalPrice.innerHTML = "";
      modalPrice.innerHTML = `<i class="fas fa-dollar-sign"></i>${(price/100).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')}`;
      document.querySelector("#splitable").value = false;
    }
  })
}

const renderToggle = () => {
  return `<div class="card-toggle">
            <div>
              <label class="switch">
                <input class="splitable" type="checkbox">
                <span class="slider round"></span>
              </label>
            </div>
          </div>`;
};

const getToggle = (cardId) => {
  return document.querySelector(".card-toggle").querySelector(".splitable").checked === true;
};

const cleanInnerTexts = (fieldsArray) => {
  fieldsArray.forEach((field) => {
    field.innerHTML = "";
  });
};

const addInnerTexts = (data, cardId, modalBusinessName, modalFieldName, modalselectedHour, modalselectedDate, modalBusinessAddress, modalCapacity, modalPrice, modalSplitableDiv) => {
  const bookingDate = document.querySelector(".schedule-btn.btn.btn-xs.active").children[0].value.split("-");
  const bookingTime = document.querySelector(".schedule-btn.btn.btn-xs.active").children[0].dataset.time
  const bookingDateTime = new Date(bookingDate[0],bookingDate[1]-1, bookingDate[2], bookingTime, 0);
  modalBusinessName.insertAdjacentHTML("beforeend", `${data.business.name}`);
  modalFieldName.insertAdjacentHTML("beforeend", `<i class="em em-soccer"></i>${data.name}`);
  modalselectedHour.insertAdjacentHTML("beforeend", `${formatHour(parseInt(bookingTime, 10))} - ${formatHour(parseInt(bookingTime, 10) + 1)}`);
  modalselectedDate.insertAdjacentHTML("beforeend", `${bookingDate.join('-')}`);
  modalBusinessAddress.insertAdjacentHTML("beforeend", `${data.business.address}`);
  modalSplitableDiv.insertAdjacentHTML("beforeend", renderToggle());
  modalCapacity.insertAdjacentHTML("beforeend", `${data.capacity} Jugadores`);
  modalPrice.insertAdjacentHTML("beforeend", `<i class="fas fa-dollar-sign"></i>${(data.price_cents/100).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')}`);
  document.querySelector("#field_id").value = parseInt(cardId, 10);
  document.querySelector("#bookingDate").value = bookingDateTime;
  document.querySelector("#splitable").value = getToggle(cardId) ;
  document.querySelector("#number_players").value = data.capacity ;
};

const sendInfoToTheModal = (cardId) => {
  const modalBusinessName = document.querySelector(".modal-business-name-header > h3")
  const modalFieldName = document.querySelector(".modal-field-name")
  const modalselectedHour = document.querySelector(".modal-selected-time > p")
  const modalselectedDate = document.querySelector(".modal-selected-date > p")
  const modalBusinessAddress = document.querySelector(".modal-business-address > p")
  const modalCapacity = document.querySelector(".modal-capacity > p")
  const modalPrice = document.querySelector(".modal-price-value")
  const modalSplitableDiv = document.querySelector(".modal-splitable");
  const fieldsArray = [modalBusinessName, modalFieldName, modalselectedHour,  modalselectedDate, modalBusinessAddress, modalCapacity, modalPrice, modalSplitableDiv];

  const url = ('/fields/' + cardId)
  fetch(url)
    .then(response => response.json())
    .then((data) => {
      cleanInnerTexts(fieldsArray);
      addInnerTexts(data, cardId, modalBusinessName, modalFieldName, modalselectedHour, modalselectedDate, modalBusinessAddress, modalCapacity, modalPrice, modalSplitableDiv);
      makeChangesIfToggleChanges(cardId, modalPrice, data.price_cents, data.capacity)
    });
};

export default sendInfoToTheModal;

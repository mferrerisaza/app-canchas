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
      // document.querySelector(`#toggle${cardId}`).querySelector(".splitable").checked = true;
      modalPrice.querySelector("p").innerHTML = "";
      modalPrice.querySelector("p").innerHTML = `$ ${(price/100/capacity).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')} por jugador`;
      modalSplitableDiv.querySelector("input").value = true;
    } else {
      // document.querySelector(`#toggle${cardId}`).querySelector(".splitable").checked = false;
      modalPrice.querySelector("p").innerHTML = "";
      modalPrice.querySelector("p").innerHTML = `$ ${(price/100).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')}`;
      modalSplitableDiv.querySelector("input").value = false;
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
  console.log(document.querySelector(".card-toggle").querySelector(".splitable"));
  return document.querySelector(".card-toggle").querySelector(".splitable").checked === true;
};

const cleanInnerTexts = (fieldsArray) => {
  fieldsArray.forEach((field) => {
    field.innerHTML = "";
  });
};

const addInnerTexts = (data, cardId, modalBusinessName, modalFieldName, modalselectedHour, modalBusinessAddress, modalCapacity, modalPrice, modalSplitableDiv) => {
  const bookingDate = document.querySelector(".schedule-btn.btn.btn-xs.active").children[0].value.split("-");
  const bookingTime = document.querySelector(".schedule-btn.btn.btn-xs.active").children[0].dataset.time
  const bookingDateTime = new Date(bookingDate[0],bookingDate[1]-1, bookingDate[2], bookingTime, 0);
  modalBusinessName.insertAdjacentHTML("beforeend", `<h3 dataset=${cardId}> ${data.business.name} </h3>`);
  modalFieldName.insertAdjacentHTML("beforeend", `<h5> ${data.name} </h5>`);
  modalselectedHour.insertAdjacentHTML("beforeend", `Reservar esta cancha el ${bookingDate} entre ${formatHour(parseInt(bookingTime, 10))} y ${formatHour(parseInt(bookingTime, 10) + 1)}`);
  modalBusinessAddress.insertAdjacentHTML("beforeend", `<p> ${data.business.address} </p>`);
  modalSplitableDiv.insertAdjacentHTML("beforeend", renderToggle());
  modalCapacity.insertAdjacentHTML("beforeend", `<p> Número de jugadores: ${data.capacity} </p>`);
  // if (getToggle(cardId)) {
  //   modalPrice.insertAdjacentHTML("beforeend", `<p> $ ${(data.price_cents/100/data.capacity).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')} por jugador</p>`);
  // } else {
  //   modalPrice.insertAdjacentHTML("beforeend", `<p> $ ${(data.price_cents/100).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')} </p>`);
  // };
  modalPrice.insertAdjacentHTML("beforeend", `<p> $ ${(data.price_cents/100).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')} </p>`);
  document.querySelector("#field_id").value = parseInt(cardId, 10);
  document.querySelector("#bookingDate").value = bookingDateTime;
  document.querySelector("#splitable").value = getToggle(cardId) ;
};

const sendInfoToTheModal = (cardId) => {
  const modalBusinessName = document.querySelector(".modal-business-name")
  const modalFieldName = document.querySelector(".modal-field-name")
  const modalselectedHour = document.querySelector(".modal-selected-hour")
  const modalBusinessAddress = document.querySelector(".modal-business-address")
  const modalCapacity = document.querySelector(".modal-capacity")
  const modalPrice = document.querySelector(".modal-price")
  const modalSplitableDiv = document.querySelector(".modal-splitable");
  const fieldsArray = [modalBusinessName, modalFieldName, modalselectedHour, modalBusinessAddress, modalSplitableDiv, modalCapacity, modalPrice];

  const url = ('/fields/' + cardId)
  fetch(url)
    .then(response => response.json())
    .then((data) => {
      cleanInnerTexts(fieldsArray);
      addInnerTexts(data, cardId, modalBusinessName, modalFieldName, modalselectedHour, modalBusinessAddress, modalCapacity, modalPrice, modalSplitableDiv);
      makeChangesIfToggleChanges(cardId, modalPrice, data.price_cents, data.capacity)
    });
};
const getCardId = (event) => {
    const cardId = event.currentTarget.dataset.id;
    sendInfoToTheModal(cardId);
  };

const addListenerOnClick = (btn) => {
  btn.addEventListener("click", getCardId);
};

export default function selectCtaButtons() {
  const ctaButtons = document.querySelectorAll(".card-cta");
  ctaButtons.forEach(addListenerOnClick);
};

document.addEventListener("DOMContentLoaded", () => {
  selectCtaButtons();
});

